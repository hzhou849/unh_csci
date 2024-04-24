"""
States collection v-iteration list
collection of state cell nodes
"""
import array as arr
from LinkedList import LinkedList
import copy

class StateCell:
    def __init__(self, stateNum,  vVal, ngbrList):
        self.stateNum = stateNum
        self.vVal = vVal
        self.ngbrList = ngbrList
        self.prevNodes = None
        self.nextNodes = None
        self.bestPathList = []

class StateCollection:
    def __init__(self, label):
        self.label = label
        self.collection = []
        self.statesList = [1,2,3,4,5,6]
        # Maze visualization with walls
        self.maze = [2,  0, 3,  0, 4,
                     0,  0, 0,  0, 0,
                     1, -1, 6, -1, 5]
        self.initCells()
        # self.bestPath = LinkedList()
        self.head = None
    def initCells(self):
        ngbrList = []

        for index, element in enumerate(self.statesList):
            ngbrList = self.getNgbr(element)
            tempCell = StateCell(element, 0, ngbrList)
            self.collection.append(tempCell)

    def getNgbr(self, state):
        maxCol = 5
        maxRow = 3
        SHIFT_VAL = 2
        WALL = -1


        ngbrList=[]
        ngbrList.append(state)  # each state is always a neighbour of itself.


        ''' Helper function'''
        def flatConvert(statePos):
            """
            returns state position from 1-D cell address
            """

            for index, element in enumerate(self.maze):
                if index == statePos:
                   return element




        if state == 1:
            xPos, yPos = 0, 2
        elif state == 2:
            xPos, yPos = 0, 0
        elif state == 3:
            xPos, yPos = 2, 0
        elif state == 4:
            xPos, yPos = 4, 0
        elif state == 5:
            xPos, yPos = 4, 2
        elif state == 6:
            xPos, yPos = 2, 2
        else:
            return (self.__name__ + "ERROR: position out of range")

        flatPos = (yPos * maxCol) + xPos

        # wall cell position NORTH
        tempY = yPos - 1
        if (tempY) >=0:
            ngbrCell = (tempY * maxCol) + xPos
            # if wall cell check up  is successful, return neighbour state
            if (self.maze[ngbrCell] != WALL):
                tempY = yPos - SHIFT_VAL
                stateNum = flatConvert((tempY * maxCol) + xPos)
                ngbrList.append(stateNum)

        # wall check EAST
        tempX = xPos + 1
        if tempX <= maxCol - 1:
            ngbrCell = (yPos * maxCol) + tempX
            if (self.maze[ngbrCell] != WALL):
                tempX = xPos + SHIFT_VAL
                stateNum = flatConvert((yPos * maxCol) + tempX)
                ngbrList.append(stateNum)

        # wall position SOUTH
        tempY = yPos + 1
        if tempY <= maxRow -1:
            ngbrCell = (tempY * maxCol) + xPos
            if (self.maze[ngbrCell] != WALL):
                tempY = yPos + SHIFT_VAL
                stateNum = flatConvert((tempY * maxCol) + xPos)
                ngbrList.append(stateNum)

        # wall check WEST
        tempX = xPos - 1
        if tempX >= 0:
            ngbrCell = (yPos * maxCol) + tempX
            if (self.maze[ngbrCell] != WALL):
                tempX = xPos - SHIFT_VAL
                stateNum = flatConvert((yPos * maxCol) + tempX)
                ngbrList.append(stateNum)

        return ngbrList


    def getNgbrList(self, stateCell):
        return self.collection[stateCell - 1].ngbrList
    def getBestPath(self, stateCell):

        return self.collection[stateCell-1].bestPathList

    def updateCell(self, cellNum, vVal):
        if cellNum < 0:
            return (self.__name__ + "ERROR: cellNum out of bounds")
        self.collection[cellNum - 1].vVal = vVal

    def updateBestPath(self,stateCell, bestNum):

        self.collection[stateCell-1].bestPathList.append(bestNum)

    def clearExistingPath(self, stateCell):
        self.collection[stateCell-1].bestPathList.clear()

    def getNode(self, stateCell):
        return self.collection[stateCell-1]

    def linkNodes(self, source, dest):
        self.collection[source - 1]

    def findMaxState(self):
        maxValue = 0
        maxState = 0
        for index ,el in enumerate(self.collection):
            print("s : {}; val: {:0.8f}".format(el.stateNum, el.vVal))
            if el.vVal > maxValue:
                maxValue = el.vVal
                maxState = el.stateNum
        print("Max state found is : {}; val: {}".format(maxState, maxValue))
        return maxState




    def printCollection(self):
        for index, el in enumerate(self.collection):
            print("s{})ngbr:  {};\tvVal:{:0.8f}; \tbestPath:{}\n"
                  .format(el.stateNum, el.ngbrList, el.vVal, el.bestPathList))


            # tempNode = el.bestPathNext
            # while tempNode != None:
            #     print("node val: {}".format(tempNode.vVal))
            #     tempNode = tempNode.bestPathNext

