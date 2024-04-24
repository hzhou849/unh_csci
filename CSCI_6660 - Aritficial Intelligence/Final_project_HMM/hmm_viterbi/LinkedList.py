"""
Linked list - Python
"""

class Node:
    def __init__(self, data):
        self.data = data
        self.next = None


class LinkedList:
    def __init__ (self):
        self.head = None
        self.length = 0

    def addNode(self, data):
        '''
        Add node to beginning of list; New node is head
        '''

        newNode = Node(data)

        print("Linked list cell added: s{}; val:{:0.4f};".format(data.stateNum, data.vVal))
        if self.head == None:
            self.head = newNode
            return
        else:
            newNode.next = self.head
            self.head = newNode

        self.length += 1

    def printList(self):
        tempNode = self.head
        while tempNode != None:
            print("node: {}".format(tempNode.data.stateNum))
            tempNode = tempNode.next



    def getNode(self, index):
        """
        Returns the node at a specific location
        """
        if index > self.length:
            return (self.__name__ + "ERROR: index out of bounds.")

        tempNode = self.head
        retNode = self.length - index
        for i in range(retNode):
            tempNode = tempNode.next

        return tempNode
