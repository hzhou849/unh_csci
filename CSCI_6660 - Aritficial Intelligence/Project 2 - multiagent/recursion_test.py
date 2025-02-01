"""
Recursion function test of nodes

test to mimic this tree
                                          (P) optMax=(9, west)
                                     W /   S |    E\
                                    (G)     (G)    (G)
                                 E /  N\   E/ N\   E/ N\
                                 9    9    -1 -1   -1 -1

"""
import sys


legalActions = (['West', 'South', 'East' ], ['East', 'North'] )
values = ( [9,9], [-1, -1], [2,2] )
class Rtest:
    def __init__(self):

        self.DEPTH = 2
        self.numAgents = 2
        self.itrCounter = 0
        self.pathCounter = 0
        self.PAC_ITR_COUNT = 0
    def getLegalActions(self, agentIndex):
        return legalActions[agentIndex]

    def selfEvaluationFucntion(self, tempDepth, agentIndex):
        if self.itrCounter > 1:
            self.itrCounter = 0
            self.pathCounter +=1
        eval = values[self.pathCounter][self.itrCounter]
        self.itrCounter +=1
        return eval
    def recursion_test(self, itrCount, tempDepth, agentIndex):



        if tempDepth == self.DEPTH and agentIndex == 0:
            getEval = self.selfEvaluationFucntion(tempDepth, agentIndex)
            return None, getEval  # return Ghost agent values

        optVal = -sys.maxsize if agentIndex == 0 else sys.maxsize
        optMove = ''
        # agents=[ 0,1 ]; bc 0 indexed
        # If tempDepth equals agentIndex that means we have fully explored
        nextDepth = tempDepth + 1 if (agentIndex+1) == self.numAgents else tempDepth


        for move in self.getLegalActions(agentIndex):
            if agentIndex > 0:
                for i in range(agentIndex):
                    print("\t", end="")
            print ("AGENT: {}, move:{}".format(agentIndex, move))

            #increment the agentIndex
            nextIndex = (agentIndex + 1) % self.numAgents
            _, nextVal = self.recursion_test(itrCount, nextDepth, nextIndex)

            if agentIndex == 0 and optVal < nextVal:
                optVal = nextVal
                optMove = move
            elif agentIndex > 0 and optVal > nextVal:
                optVal = nextVal
                optMove = move


        return optMove, optVal






if __name__ == '__main__':
    pathCounter = 0
    itrCounter = 0
    r = Rtest()
    optMove, optVal = r.recursion_test( 0,0, 0)
    print("Pacman's optMove: {}; optVal:{}".format(optMove, optVal))