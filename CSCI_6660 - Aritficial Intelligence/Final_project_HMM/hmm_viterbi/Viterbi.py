"""
CSCI 6660 - Artificial Intelligence

Final Proejct - Robot tracking/localization HMM using Viterbi decoding Algorithm
Name: Howard Zhou

0=s1, 1=s2, 2=s3, 3=s4, 4=s5, 5=s6
"""

import array as arr
import sys
from LinkedList import LinkedList
from LinkedList import Node
from StateCollection import StateCollection, StateCell

class StateCell:
    def __init__(self, data):
        self.data = data
        self.next = None

class Viterbi:
    def __init__(self, input1):
        self.input1 = input1
        self.statesList = None
        rows, cols = (6,6)
        self.trans_prob = [ [float(0) for i in range(cols)] for j in range(rows)]
        self.evidence_prob = [ [float(0) for i in range(6)] for j in range(4)]
        self.t0_prob = None
        self.maze =[ [float(0) for i in range(4)] for j in range(3) ]
        self.timeStep = []
        self.init_specs()
        self.evidenceObserved = ["ESW", "N", "NE", "ESW", "NE"]

        self.evidence_dict = {}  # Must be declared in constructor
        self.evidence_dict['ESW'] = [0.8421, 0.0286, 0.0784, 0.0222, 0.8421, 0.8421]
        self.evidence_dict['NW'] = [0.0263, 0.9143, 0.0196, 0.0222, 0.0263, 0.0263]
        self.evidence_dict['N'] = [0.1053, 0.0286, 0.6275, 0.2444, 0.1053, 0.1053]
        self.evidence_dict['NE'] = [0.0263, 0.0286, 0.2157, 0.7111, 0.0263, 0.0263]
        self.bestPathCollection = []



    def init_specs(self):
        """
        Set initial probability tables for this scenario
        """

        # States on the board 3x2
        self.statesList = arr.array('i', [1,2,3,4,5,6])

        # Initial probability at t0
        self.t0_prob = 1/6

        # Transition probabilities
        self.trans_prob = [ [0.2, 0.4, 0.0,  0.0, 0.0, 0.0],
                            [0.8, 0.2, 0.27, 0.0, 0.0, 0.0],
                            [0.0, 0.4, 0.2,  0.4, 0.0, 0.8],
                            [0.0, 0.0, 0.27, 0.2, 0.8, 0.0],
                            [0.0, 0.0, 0.0,  0.4, 0.2, 0.0],
                            [0.0, 0.0, 0.27, 0.0, 0.0, 0.2]
                           ]

        # Evidence probabilities (Normalized) P(et | xt); EO = (1-error_rate)^4-d * e^d
        self.evidence_prob = [ [0.8421, 0.0286, 0.0784, 0.0222, 0.8421, 0.8421],
                               [0.0263, 0.9143, 0.0196, 0.0222, 0.0263, 0.0263],
                               [0.1053, 0.0286, 0.6275, 0.2444, 0.1053, 0.1053],
                               [0.0263, 0.0286, 0.2157, 0.7111, 0.0263, 0.0263]
                             ]


    def start(self):


            for i in range(len(self.statesList)):
                print(i)

            print("\ninitial probability: {}".format(self.t0_prob))
            # Print each element of row in 2D array
            print("\nTransition Probabilties (Et | Xt): ")
            for row in self.trans_prob:
                print(row)

            print("\nEvidence Probabilites: ")
            for row in self.evidence_prob:
                print(row)

            # Initialize collection of all iterations
            for i, el in enumerate(self.evidenceObserved):
                self.timeStep.append(StateCollection("v({})_E({})".format(i, el)))



            for tIndex, tStep in enumerate(self.timeStep):
                print("============v({})_E({})========".format(tIndex, self.evidenceObserved[tIndex]))
                # Initialize first iteration with initial probabilites
                if tIndex == 0:
                    # print("\nExtracting first iteration")
                    # print(self.timeStep[0].printCollection())
                    key = self.evidenceObserved[0]  # get first observation 'ESW'
                    for cellNum in self.statesList:
                        probE1_X0 = round(self.evidence_dict[key][cellNum-1] * self.t0_prob, 8)
                        self.timeStep[0].updateCell(cellNum, probE1_X0)
                        # print("setting probabiltiy for cell{}; prob:{:0.4f}".format(cellNum, probE1_X0))
                        self.timeStep[0].getNode(cellNum)
                        self.timeStep[0].updateBestPath(cellNum,cellNum )
                        # prevBestPath = self.timeStep[0].getBestPath(cellNum)
                        # for i in prevBestPath:
                        #     print(prevBestPath)
                else:
                    key = self.evidenceObserved[tIndex]
                    print("\nCalculating time step:{}".format(tIndex))
                    for cellNum in self.statesList:
                        bestPathNode = None
                        maxViteriVal = -sys.maxsize
                        ngbrList = self.timeStep[tIndex].getNgbrList(cellNum)
                        maxPathCell = 0
                        print("\ncellNum:{}; ngbrList: {}".format(cellNum, ngbrList))
                        for index, ngbrCell in enumerate(ngbrList):
                            print("s{}->s{}".format(ngbrCell, cellNum))
                            evidProb = self.evidence_dict[key][cellNum-1]
                            transProb = self.trans_prob[cellNum-1][ngbrCell-1]
                            prevTstepNgbrVitVal = self.timeStep[tIndex-1].getNode(ngbrCell).vVal
                            print(prevTstepNgbrVitVal)
                            vVal = round(prevTstepNgbrVitVal * (evidProb * transProb),8)
                            print("evid:{} * trans:{} * prevVal({}):{}".format(evidProb, transProb,ngbrCell, prevTstepNgbrVitVal))
                            print("t{}; ngbrCell:{}; vVal: {:0.8f}\n".format(tIndex, ngbrCell, vVal))

                            if vVal > maxViteriVal:
                                maxViteriVal = vVal
                                maxPathCell = ngbrCell
                                self.timeStep[tIndex].updateCell(cellNum, maxViteriVal)
                            if index+1 == len(ngbrList):
                                self.timeStep[tIndex].clearExistingPath(cellNum)
                                self.timeStep[tIndex].updateBestPath(cellNum, maxPathCell)

                                prevBestPath = self.timeStep[tIndex-1].getBestPath(maxPathCell)
                                for i in prevBestPath:
                                    print("s{}: {}".format(cellNum, i))
                                    self.timeStep[tIndex].updateBestPath(cellNum, i)

                print("\ncollections:{}".format(tStep.label))
                tStep.printCollection()

            ''' look for best path'''
            lastTimeStep = len(self.evidenceObserved) -1

            maxState = self.timeStep[lastTimeStep].findMaxState()
            print ("final backtrace maxstate:".format(maxState))
            print("[END]-->{}".format(maxState), end="")
            prevVal = 0
            for i in self.timeStep[lastTimeStep].getBestPath(maxState):
                if i != prevVal:
                    print ("-->{}".format(i), end="")
                    prevVal = i