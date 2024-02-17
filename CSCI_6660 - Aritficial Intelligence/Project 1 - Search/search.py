# search.py
# ---------
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


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""
import copy
import util


# Constant defines
ATTR_XY   = 0
ATTR_DIR  = 1
ATTR_COST = 2


# Helper functions
def printData(self):
	tempDataStruc = self
	itr=0
	print("\n--------------------------------------------------------------")
	print("\tDumping Data structure: " + str(type(self)))
	for el in tempDataStruc.list:
		print("\t{}) dumping {}: {}".format(itr, type(self),el))
		itr += 1
	print("----------------------------------------------------------------\n")

class SearchProblem:
	"""
	This class outlines the structure of a search problem, but doesn't implement
	any of the methods (in object-oriented terminology: an abstract class).

	You do not need to change anything in this class, ever.
	"""

	def getStartState(self):
		"""
		Returns the start state for the search problem.
		"""
		util.raiseNotDefined()

	def isGoalState(self, state):
		"""
		  state: Search state

		Returns True if and only if the state is a valid goal state.
		"""
		util.raiseNotDefined()

	def getSuccessors(self, state):
		"""
		  state: Search state

		For a given state, this should return a list of triples, (successor,
		action, stepCost), where 'successor' is a successor to the current
		state, 'action' is the action required to get there, and 'stepCost' is
		the incremental cost of expanding to that successor.
		"""
		util.raiseNotDefined()

	def getCostOfActions(self, actions):
		"""
		 actions: A list of actions to take

		This method returns the total cost of a particular sequence of actions.
		The sequence must be composed of legal moves.
		"""
		util.raiseNotDefined()


def tinyMazeSearch(problem):
	"""
	Returns a sequence of moves that solves tinyMaze.  For any other maze, the
	sequence of moves will be incorrect, so only use this for tinyMaze.
	"""
	from game import Directions
	print("Start:", problem.getStartState())
	print("Is the start a goal?", problem.isGoalState(problem.getStartState()))
	print("Start's successors:", problem.getSuccessors(problem.getStartState()))

	newState = problem.getSuccessors(problem.getStartState())[0]

	s = problem.getStartState()
	for i in problem.getSuccessors(s):
		print("s type: {}".format( type(s)) )
		print ("getSucessor: {}".format(i))



	print ("if using 5,4: {}". format(newState))


	print ("options of new state: {}". format(problem.getSuccessors(newState[0])))
	s = Directions.SOUTH
	w = Directions.WEST
	e = Directions.EAST
	# return  [s, s, w, s, w, w, s, w]
	return  [w, w, w, w, s, s, e, s,s, w]

def depthFirstSearch(problem):
	"""
	Search the deepest nodes in the search tree first.

	Your search algorithm needs to return a list of actions that reaches the
	goal. Make sure to implement a graph search algorithm.

	To get started, you might want to try some of these simple commands to
	understand the search problem that is being passed in:

	print("Start:", problem.getStartState())
	print("Is the start a goal?", problem.isGoalState(problem.getStartState()))
	Be careful! this call to successor is logged as an 'expanded' node when using autograder
	print("Start's successors:", problem.getSuccessors(problem.getStartState()))

	Check work with problem.getExpandedStates()
	"""

	"*** YOUR CODE HERE ***"

	print("\n==========  DFS   ==============")
	# Local variables
	attrXY 	= 0
	attrDir = 1

	# Local variables
	stk   = util.Stack()
	path  = util.Stack()
	start = problem.getStartState()
	stk.push([(start, None)])
	visited = {start}

	while stk.isEmpty() == False:

		currPath = stk.pop()

		# <t1, t2, t3> = var to hold set[i]   = {extract from last entry of currPath[-1]
		# Assigns state = currPath[-1] fist, then breaks the tuples into var1, var2, var3
		currNode, dir = nodeElement = currPath[-1]
		visited.add(currNode)

		if problem.isGoalState(currNode):
			# return dirs only, not points, first dir is "None" so filter that out
			for p in currPath:
				if p[attrDir] != None:
					path.push(p[attrDir])
			return path.list

		# Get the successor values; *calling getSuccessors counts as expanded
		for ssrNode, ssrDir, ssrCost in problem.getSuccessors(currNode):
			if ssrNode not in visited:
				stk.push( currPath + [ (ssrNode, ssrDir) ])


def breadthFirstSearch(problem):
	"""Search the shallowest nodes in the search tree first."""
	"""
		Function Breadth-First-Search(problem) returns a solution, or failure
		node<- a node with State =problem.initialState, pathCost=0
		if problem.goalTest(node.state),  then return Solution(node)
		dataList <- FIFO queue with node as the only element
		explored <- an empty set
		loop do()
			if dataList.isEmpty(), then return EXIT_FAILURE
			currNode <-dataList().pop() # Shallowest node in list
			explored.add(currNode.state)
			
			for each action in problem.getSuccessor(currNode) do
				child<- childNode(problem, node, action)
				
				if child.state is not in explored or dataList
					if problem.goalTest(child.state) then return Solution
					dataList<- push(child)
	"""

	"*** YOUR CODE HERE ***"
	print("\n==========  BFS   ==============")

	# Local variables
	attrXY  = 0
	attrDir = 1
	qList   = util.Queue()  # BFS utilizes queue for shallowest node
	path    = util.Stack()
	start   = problem.getStartState()
	explored = set()

	qList.push( [(start, None)] )
	while qList.isEmpty() == False:
		currPath = qList.pop()
		# extract the attributes from currPath top node
		currNode, currDir  = nodeElement =  currPath[-1]

		if problem.isGoalState(currNode):
			# return the direction path list
			for p in currPath:
				if p[attrDir] != None:
					path.push(p[attrDir])
			return path.list

		# Get the successor actions and enqueue them if not explored
		if currNode not in explored:
			for ssrNode, ssrDir, ssrCost in problem.getSuccessors(currNode):
				qList.push(currPath + [(ssrNode, ssrDir)])
				explored.add(currNode)


def uniformCostSearch(problem):
	"""Search the node of least total cost first."""
	"""
	function Uniform-Cost-Search(problem) returns a solution, or failure
	node <- a node with STATE = problem.initialStatePathCost = 0
	frontier<- a priorityQueue ordered by pathCost, with node as the only element
	explored <- an empty set
	loop do
		if frontier.isEmpty, then return failure
		currNode<-frontier.pop()  // Chooses the lowest cost node
		if problem.goalTest(currNode) then return solution(node)
		 	return path // done!
		explored.add(currNode)
		
		for each ssrNode in getSuccessor(currNode) do
			// ssrNode is child successorNodes
			if ssrNode is not in explored or frontier
				frontier.push(ssrNode)
			else if ssrNode already exists in frontier with HIGHER pathCost() then
				replace existing frontier node with ssrNode
			
	"""
	"*** YOUR CODE HERE ***"
	print ("start state: {}".format(problem.getStartState()))
	# Local variables:
	attrXY = 0
	attrDir = 1
	start = problem.getStartState()
	path  = util.Stack()
	pQueue = util.PriorityQueue()  # frontier (node, int priority)
	explored=set()
	pQueue.push([(start, None, 0)],0 )

	while pQueue.isEmpty() == False:
		fringe = pQueue.pop()  # Chooses the lowest cost node

		currNode, currDir, currCost = nodeElement =fringe[-1]

		# if goal is found
		if problem.isGoalState(currNode):
			for p in fringe:
				if p[attrDir] != None:
					path.push(p[attrDir])
			return path.list

		if currNode not in explored:
			for ssrNode, ssrDir, ssrCost in problem.getSuccessors(currNode):
				# Remember cost is cumulative!!!
				if ssrNode not in explored: # reduce redundant calculations
					pQueue.update(fringe + [(ssrNode, ssrDir,ssrCost+currCost)], ssrCost+currCost)
					explored.add(currNode)

def nullHeuristic(state, problem=None):
	"""
	A heuristic function estimates the cost from the current state to the nearest
	goal in the provided SearchProblem.  This heuristic is trivial.
	"""
	return 0

def aStarSearch(problem, heuristic=nullHeuristic):

	"""Search the node that has the lowest combined cost and heuristic first."""

	'''
	g(n) backwards cost(UCS)
	h(n) the heuristic cost of the destination node only. Not cumulative
	f(n) = g(n) + h(n)
	'''
	"*** YOUR CODE HERE ***"

	'''Helper functions'''
	# Method 1 - using traditional helper function
	#  to calculate heuristic value
	def calcHeuristic(backCost, nodeEl):
		nodeXy, nodeDir, nodeCost = nodeEl
		return backCost + heuristic(nodeXy, problem)

	# Method 2 - using Lambda function instead
	# Lambda function to calculate functions
	#calcHn = lambda tempNode: tempNode[ATTR_COST] + heuristic(tempNode[ATTR_XY], problem)


	"""Local variables """
	start = problem.getStartState()
	path = util.Stack()
	# pQueue = util.PriorityQueueWithFunction(calcHeuristic)  #calculates the h(n) on push() with provided f(n)
	pQueue = util.PriorityQueue()
	explored=set()
	pQueue.push( [(start,None,0)],0)   # any item pushed in here will get passed into the attached function to calculate
	print("manhattan h(n): {}; {}".format(start, heuristic(start, problem)))

	while pQueue.isEmpty() == False:
		fringe = pQueue.pop()  # returns the lowest cost node
		# print ("fringe: "+ str(fringe))
		currNode, currDir, currCost = nodeElement = fringe[-1]  # nodeElement required to get the last list_el of list

		if problem.isGoalState(currNode):
			for p in fringe:
				if p[ATTR_DIR] != None:
					path.push(p[ATTR_DIR])
			return path.list

		if currNode not in explored:
			for ssrNode in problem.getSuccessors(currNode):
				ssrXy, ssrDir, ssrCost = ssrNode
				if ssrXy not in explored:  # reduce redundant calculations
					backCost = currCost+ssrCost
					hcost = calcHeuristic(backCost, ssrNode)
					pQueue.push(fringe + [(ssrXy, ssrDir, backCost )], calcHeuristic(backCost,ssrNode))
					explored.add(currNode)




	# util.raiseNotDefined()


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
