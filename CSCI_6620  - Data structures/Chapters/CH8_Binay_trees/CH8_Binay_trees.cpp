// CH8_Binay_trees.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "Tree.h"



int main()
{
    int treeLength;
    Tree myTree;

    myTree.PutItem(10);
    myTree.PutItem(5);
    myTree.PutItem(12);
    myTree.PutItem(3);
    myTree.PutItem(2);
    myTree.PutItem(16);
    myTree.PutItem(6);

    
    treeLength = myTree.GetLength();

   
    Node *index = myTree.getRoot();
    //myTree.PrintTree(index);
    myTree.GuiPrint(index);


}
