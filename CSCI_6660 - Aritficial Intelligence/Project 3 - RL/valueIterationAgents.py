# valueIterationAgents.py
# -----------------------
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

# valueIterationAgents.py
# -----------------------
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


import mdp, util

from learningAgents import ValueEstimationAgent
import collections

class ValueIterationAgent(ValueEstimationAgent):
    """
        * Please read learningAgents.py before reading this.*

        A ValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs value iteration
        for a given number of iterations using the supplied
        discount factor.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 100):
        """
          Your value iteration agent should take an mdp on
          construction, run the indicated number of iterations
          and then act according to the resulting policy.

          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state, action, nextState)
              mdp.isTerminal(state)
        """
        self.mdp = mdp
        self.discount = discount
        self.iterations = iterations
        self.values = util.Counter() # A Counter is a dict with default 0
        self.runValueIteration()

    def runValueIteration(self):
        # Write value iteration code here
        "*** YOUR CODE HERE ***"
        self.actions = util.Counter()

        """ Helper functions"""
        def calcValues(state, prevValues):
            value = -sys.maxsize

            if state == 'TERMINAL_STATE':
                self.actions[state] = None
                value = 0

            for a in self.mdp.getPossibleActions(state):
                sum = 0
                trans = self.mdp.getTransitionStatesAndProbs(state, a)
                for tx in trans:
                    sPrime = tx[0]
                    prob = tx[1]
                    prevVal = prevValues[sPrime]
                    reward = self.mdp.getReward(state, a, sPrime)

                    # V_k-1 = previous value
                    # Value Iteration formula t[s,a,s'][R(s,a,s') + discount * prevValue
                    sum += prob * (reward + ( self.discount * prevVal) )

                if sum > value:
                    value = sum
                    self.actions[state] = a

            return value


        currStates = self.mdp.getStates()
        for itr in range(self.iterations):
            valuesCopy = self.values.copy()
            for s in currStates:
                self.values[s] = calcValues(s, valuesCopy)

    def getValue(self, state):
        """
          Return the value of the state (computed in __init__).
        """
        return self.values[state]


    def computeQValueFromValues(self, state, action):
        """
          Compute the Q-value of action in state from the
          value function stored in self.values.
        """
        "*** YOUR CODE HERE ***"
        Qvalue = 0
        transFunction = self.mdp.getTransitionStatesAndProbs(state, action)
        for nextState, prob in transFunction:
            reward = self.mdp.getReward(state, action, nextState)
            Qvalue += prob * ( reward + (self.discount * self.values[nextState]) )

        return Qvalue


    def computeActionFromValues(self, state):
        """
          The policy is the best action in the given state
          according to the values currently stored in self.values.

          You may break ties any way you see fit.  Note that if
          there are no legal actions, which is the case at the
          terminal state, you should return None.
        """
        "*** YOUR CODE HERE ***"
        possibleActions = self.mdp.getPossibleActions(state)

        if len(possibleActions) == 0:
            return None

        value = None
        result = None
        for action in possibleActions:
            temp = self.computeQValueFromValues(state, action)
            if value == None or temp > value:
                value = temp
                result = action

        return result

    def getPolicy(self, state):
        return self.computeActionFromValues(state)

    def getAction(self, state):
        "Returns the policy at the state (no exploration)."
        return self.computeActionFromValues(state)

    def getQValue(self, state, action):
        return self.computeQValueFromValues(state, action)

class AsynchronousValueIterationAgent(ValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*

        An AsynchronousValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs cyclic value iteration
        for a given number of iterations using the supplied
        discount factor.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 1000):
        """
          Your cyclic value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy. Each iteration
          updates the value of only one state, which cycles through
          the states list. If the chosen state is terminal, nothing
          happens in that iteration.

          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state)
              mdp.isTerminal(state)
        """
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        index = 0
        mdpStates = self.mdp.getStates()
        stateLen = len(mdpStates)


        for itr in range (0, self.iterations):
            modNum = itr % stateLen
            currState = mdpStates[ itr % stateLen ]

            if self.mdp.isTerminal(currState):
                continue

            optAction = self.computeActionFromValues(currState)
            QValue = self.computeQValueFromValues(currState, optAction)
            self.values[currState] = QValue


class PrioritizedSweepingValueIterationAgent(AsynchronousValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*

        A PrioritizedSweepingValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs prioritized sweeping value iteration
        for a given number of iterations using the supplied parameters.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 100, theta = 1e-5):
        """
          Your prioritized sweeping value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy.
        """
        self.theta = theta
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"

        pQueue = util.PriorityQueue()
        predecessors = {}
        for currState in self.mdp.getStates():
            if not self.mdp.isTerminal(currState):
                for action in self.mdp.getPossibleActions(currState):
                    for nextState, prob in self.mdp.getTransitionStatesAndProbs(currState, action):
                        if nextState in predecessors:
                            predecessors[nextState].add(currState)
                        else:
                            predecessors[nextState] = {currState}

        for currState in self.mdp.getStates():
            if not self.mdp.isTerminal(currState):
                values = []
                for action in self.mdp.getPossibleActions(currState):
                    qValue = self.computeQValueFromValues(currState, action)
                    values.append(qValue)
                diff = abs(max(values) - self.values[currState])
                pQueue.update(currState, - diff)


        for itr in range(self.iterations):
            if pQueue.isEmpty():
                break
            tempState = pQueue.pop()
            if not self.mdp.isTerminal(tempState):
                values = []
                for action in self.mdp.getPossibleActions(tempState):
                    qValue = self.computeQValueFromValues(tempState, action)
                    values.append(qValue)
                self.values[tempState] = max(values)

            for predVal in predecessors[tempState]:
                if not self.mdp.isTerminal(predVal):
                    values = []
                    for action in self.mdp.getPossibleActions(predVal):
                        qValue = self.computeQValueFromValues(predVal, action)
                        values.append(qValue)
                    diff = abs( max(values) - self.values[predVal])
                    if diff > self.theta:
                        pQueue.update(predVal, -diff)

