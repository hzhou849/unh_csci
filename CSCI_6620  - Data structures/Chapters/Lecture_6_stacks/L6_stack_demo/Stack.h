/*CSCI 6620 - Data Structures 
* Fall 2021
* 
* Lecture 6 Stacks
 * Stack demo with Exception Handling
 * 
 * Stack.h
 */


#ifndef _STACK_H
#define _STACK_H
#pragma once

#include <string>


// Custom Exceptions
class EmptyStack : public std::exception
{
public:
	EmptyStack() {}
	std::string getInfo() { return "Empty Stack Error"; }
};


class FullStack
{
public:
	FullStack() {}
	std::string getInfo() { return "Stack full error."; }
};


class Stack
{
public:
	Stack(int pMaxSize);
	~Stack();
	void Push (std::string);
	void Pop();
	void Print();

	/* Member Variables */
	std::string getTop();

private:
	
	bool IsFull() const;
	bool IsEmpty() const;

	/* Member Variables */
	int top;
	int MAX_ITEMS;			// Pre-defined max slots on stack.
	std::string *stackPtr;  // Pointer to dynamically allocated memory.

};

#endif //_STACK_H
