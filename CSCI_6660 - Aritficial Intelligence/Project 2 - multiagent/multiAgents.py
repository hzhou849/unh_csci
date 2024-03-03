# multiAgents.py
# --------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).
import sys

from util import manhattanDistance
from game import Directions
import random, util

from game import Agent

class ReflexAgent(Agent):
    """
    A reflex agent chooses an action at each choice point by examining
    its alternatives via a state evaluation function.

    The code below is provided as a guide.  You are welcome to change
    it in any way you see fit, so long as you don't touch our method
    headers.
    """


    def getAction(self, gameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {NORTH, SOUTH, WEST, EAST, STOP}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

        "*** YOUR CODE HERE ***"
        import sys

        GHOST_LIMIT_DIST=2

        ''' Metrics we want for our reflex agent'''
        newGhostPos = newGhostStates[0].getPosition()

        # Current postions specs:
        currPos = currentGameState.getPacmanPosition()
        currGhostState = currentGameState.getGhostStates()
        currFood = currentGameState.getFood().asList()
        numFood = currentGameState.getNumFood()

        # Get the ghost position
        currGhostPos = currGhostState[0].getPosition()

        gDist = util.manhattanDistance(newPos, currGhostPos)
        ssrScore = successorGameState.getScore()
        reflexPoints = 0

        # 1) if next move is win, do it at all cost
        if newPos == successorGameState.isWin():
            ssrScore = sys.maxsize
        elif newPos == successorGameState.isLose():
            ssrScore = -sys.maxsize

        # 2) Is ghost too close? Is Ghost moving away from you?
        gDist = util.manhattanDistance(currPos, currGhostPos)
        if gDist <= GHOST_LIMIT_DIST:
            mX, mY = currPos
            nX, nY = newPos
            gX, gY = currGhostPos

            # Check on x-axis change
            if action == 'West' or action == 'East':
                axisDistOld = abs(mX - gX)
                axisDistNew = abs(nX - gX)
            else: # North/South
                axisDistOld = abs(mY - gY)
                axisDistNew = abs(nY - gY)

            # If the new distance puts you away from the ghost, give it higher priority
            if axisDistNew > axisDistOld:
                reflexPoints += 10
            else:
                reflexPoints = 0

        else:  # 2) Find the closest food remaining
            minDist = sys.maxsize
            minIndex = 0
            minFoodXy = []
            for index, fLocation in enumerate(currFood):
                gDist = util.manhattanDistance(currPos, fLocation)
                if gDist < minDist:
                    minDist = gDist
                    minIndex = index
                    minFoodXy = fLocation
            print("CurrentPOS: {}; GhostPOS: {}; minFoodXy {}; minDist {}; minIndex{}".format(currPos, currGhostPos, minFoodXy, minDist, minIndex) )

            mX, mY = currPos
            tX, tY = minFoodXy

            # Get the difference to see which axis dominates
            xDiff = tX - mX
            yDiff = tY - mY

            # Check which axis dominates and then get the direction from there
            if abs(xDiff) > abs(yDiff):  # x-axis dominates
                getDir = lambda axisDiff: 'East' if axisDiff>0 else 'West'
                fDir = getDir(xDiff)
            else:  # y-axis dominates
                getDir = lambda axisDiff: 'North' if axisDiff>0 else 'South'
                fDir = getDir(yDiff)

            # If this instance action matches the food direction, give priority
            if action == fDir:
                reflexPoints += 10
                print("[+] Desired action is " + str(action))

        return reflexPoints

def scoreEvaluationFunction(currentGameState):
    """
    This default evaluation function just returns the score of the state.
    The score is the same one displayed in the Pacman GUI.

    This evaluation function is meant for use with adversarial search agents
    (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
    This class provides some common elements to all of your
    multi-agent searchers.  Any methods defined here will be available
    to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

    You *do not* need to make any changes here, but you can if you want to
    add functionality to all your adversarial search agents.  Please do not
    remove anything, however.

    Note: this is an abstract class: one that should not be instantiated.  It's
    only partially specified, and designed to be extended.  Agent (game.py)
    is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
    Your minimax agent (question 2)
    """

    def getAction(self, gameState):
        """
        Returns the minimax action from the current gameState using self.depth
        and self.evaluationFunction.

        Here are some method calls that might be useful when implementing minimax.

        gameState.getLegalActions(agentIndex):
        Returns a list of legal actions for an agent
        agentIndex=0 means Pacman, ghosts are >= 1

        gameState.generateSuccessor(agentIndex, action):
        Returns the successor game state after an agent takes an action

        gameState.getNumAgents():
        Returns the total number of agents in the game

        gameState.isWin():
        Returns whether or not the game state is a winning state

        gameState.isLose():
        Returns whether or not the game state is a losing state
        """


        "*** YOUR CODE HERE ***"
        import sys

        ''' Local variables '''
        AGENT_PACMAN = 0
        # # util.raiseNotDefined()
        # pLegaMoves = gameState.getLegalActions(AGENT_PACMAN)
        # ghostLegalMoves = gameState.getLegalActions(1)
        numAgents = gameState.getNumAgents()
        #
        #
        # for move in pLegaMoves:
        #     nextGameState = gameState.generateSuccessor(0, move)
        #     score = self.evaluationFunction(nextGameState)
        #     print("Evaluation for move:{} is score:{}".format(move, score) )



        ''' Helper function'''
        def minMax(gameState, depth, agentIndex):
            """
            Recursively find the best minMax value; Iterates through all agents and tests
            gameState.generateSuccessor(agent, move):
                    returns next game state based on agent and direction
            self.evaluationFunction(gameState):
                    returns the optimal value for that agent's state passed-in
                    PACMAN will want MAX of this; GhostAgents will want MIN of this
            Question 2 visualization [ python pacman.py -p MinimaxAgent -l minimaxClassic -a depth=1 -k1 ]
                                            (P) optMax=(9, west)
                                     W /   S |    E\
                                    (G)     (G)    (G)
                                 E /  N\   E/ N\   E/ N\
                                 9    9    -1 -1   -1 -1
            Test command:
                 python pacman.py -p MinimaxAgent -l minimaxClassic -a depth=4

            """
            triggerExit = False

            # If the next move is victorious, failure or we have reached our max depth
            # and the agentIndex has looped around from % over depth - end recursion
            if gameState.isWin() or gameState.isLose():
                triggerExit = True
            if depth == self.depth and agentIndex == 0:
                triggerExit = True

            if triggerExit == True:
                scoreVal = self.evaluationFunction(gameState)

                return None, scoreVal  # Returns values from ghost agents

            # Initialize variables here for recursion
            if agentIndex == 0:
                optValue = -sys.maxsize
            else:
                optValue = sys.maxsize
            optMove = ''

            # Do not increment depth until finished searching all agents for this depth
            # agentIndex is 0-indexed, numAgents total count of agents
            # When depth equals agentIndex, that means use the next iteration to unfold the recursion
            nextDepth = depth + 1 if agentIndex+1 == numAgents else depth

            for move in gameState.getLegalActions(agentIndex):
                if agentIndex > 0:
                    for i in range(agentIndex):
                        print("\t", end="")
                print ("AGENT: {}, move:{}".format(agentIndex, move))
                nextSuccessorState = gameState.generateSuccessor(agentIndex, move)

                # allows us to recursively interate the adversary agents only n, n-1..n-n
                # Setting nextIndex to 0 will also trigger the next recursion to return the result.
                nextIndex = (agentIndex + 1) % numAgents
                _, newVal = minMax(nextSuccessorState, nextDepth, nextIndex)


                # If this is a pacman agent[0]
                if agentIndex == AGENT_PACMAN:
                    if optValue < newVal:
                        optValue = newVal
                        optMove = move
                        print("[!] - NEW PacagentIndex: {}; move:{};  scoreVal:{}".format(agentIndex, move,  optValue))
                # Ghost agents > 0
                elif agentIndex > AGENT_PACMAN:
                    if optValue > newVal:
                        optValue = newVal
                        optMove = move
                        print("\t[!] - NEW agentIndex: {}; move: {}; scoreVal:{}".format(agentIndex, move, optValue))
            return optMove, optValue  # Return as pair item to pacman agent

        minMaxResult = minMax(gameState, 0, 0)
        return minMaxResult[0] # return only the best_move[0] not val[1]


class AlphaBetaAgent(MultiAgentSearchAgent):
    """
    Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState):
        """
        Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        # Helper print function for debugging
        def debugTierPrint(agentIndex, move, depth):
            for i in range(agentIndex+depth):
                print("\t", end ="")
            print("AGENT: {}; move: {}".format(agentIndex, move) )


        # Constants
        NUM_AGENTS   = gameState.getNumAgents()
        TIER_COUNTER = 0

        def alphaBeta(gameState, depth, agentIndex, alpha, beta):

            # Reached end depth iteration, unfold recursion here
            if gameState.isWin() or gameState.isLose() or (depth == self.depth and agentIndex ==0):
                scoreEval = self.evaluationFunction(gameState)
                return None, scoreEval

            # Initialize variables for recursion here for either min/max agent
            optValue = -sys.maxsize if agentIndex == 0 else sys.maxsize
            optMove = ''
            # When depth equals agentIndex, we have completed a depth-cycle
            nextDepth = depth + 1 if (agentIndex+1) == NUM_AGENTS else depth

            for move in gameState.getLegalActions(agentIndex):
                debugTierPrint(agentIndex, move, depth)  # debugging print
                nextSsrState = gameState.generateSuccessor(agentIndex, move)
                nextIndex = (agentIndex+1) % NUM_AGENTS     # Properly increment the AgentIndex counter
                _, newVal = alphaBeta(nextSsrState, nextDepth, nextIndex, alpha, beta)

                # Update the new min/max values accordingly by agent
                if agentIndex == 0:      # Pacman
                    if optValue < newVal:
                        optValue = newVal
                        optMove = move
                    alpha = max(alpha, optValue)

                    if alpha > beta:
                        return optMove, optValue
                elif agentIndex > 0:         # Ghost
                    if optValue > newVal:
                        optValue = newVal
                        optMove = move
                    beta = min(beta, optValue)
                    if beta < alpha:
                        return optMove, optValue
            return optMove, optValue

        alphaBetaResult = alphaBeta(gameState, 0, 0, -sys.maxsize, sys.maxsize)

        return alphaBetaResult[0]
        # util.raiseNotDefined()

class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState):
        """
        Returns the expectimax action using self.depth and self.evaluationFunction

        All ghosts should be modeled as choosing uniformly at random from their
        legal moves.
        """
        "*** YOUR CODE HERE ***"
        util.raiseNotDefined()

def betterEvaluationFunction(currentGameState):
    """
    Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
    evaluation function (question 5).

    DESCRIPTION: <write something here so we know what you did>
    """
    "*** YOUR CODE HERE ***"
    util.raiseNotDefined()

# Abbreviation
better = betterEvaluationFunction
