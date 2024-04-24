"""
HMM with Viterbi.py Algorithm Demo

CSCI 6660 - Intro to Artificial Intelligence

"""
import array
import os
import time
import mObject # import everything from mObject file

'''my project files'''
from mObject import mObject # only import the class object
import exFunctions
from Viterbi import Viterbi




# Helper functions


if __name__ == '__main__':
    # GREEN = '\033[32m'
    # END_COL = '\x1b[m'
    # # os.system('cls')
    # # print("\033[50A; {1}f{2}".format(30, 40, "Hellow again"))
    # print("\033[50A", end="")
    # # print("\033[s", end="") # Save the cursor
    # print("\033[2J", end="") # clear the screen
    # # print("\033[u", end="")
    #
    # print("new text: ", end="")
    # print("\033[s",  end="")

    # for i in range(10):
    #     print("\033[u",  end="") # Restore point
    #     time.sleep(0.100)
    #     i+=1
    #     print("\033[2C\033[2B",  end="")
    #     print(GREEN + "{}".format(i))

    # print(END_COL)

    test = mObject()
    test.add(1,2)
    # exFunctions.exMethod()


    vObj = Viterbi("")
    vObj.start()


    print("\n")








