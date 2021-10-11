// L5_stack_demo.cpp : This file contains the 'main' function. Program execution begins and ends there.
/*CSCI 6620 - Data Structures
* Fall 2021
*
* Lecture 6 Stacks
 * Stack  Dynamic ARRAY - demo with Exception Handling
 *
 * L6_stack_demo.cpp
 */

#include <iostream>
#include "Stack.h"

int main()
{
	Stack myStack(10);
	myStack.Push("node1");
	myStack.Push("node2");
	myStack.Push("node3");
	myStack.Push("node4");
	myStack.Print();
	myStack.Pop();
	myStack.Print();
}


