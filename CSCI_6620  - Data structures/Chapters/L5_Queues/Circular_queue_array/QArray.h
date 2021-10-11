#ifndef _QARRAY_H
#define _QARRAY_H
#pragma once

#include <String>

class EmptyQueue : public std::exception
{
	EmptyQueue() {}
	std::string getInfo() { return "Empty Queue Error";}
};

class FullQueue
{
	FullQueue() {}
	std::string getInfo() { return "Full Queue Error"; }
};

class QArray
{
public:
	QArray(int pMaxSize);
	~QArray();

	void push(std::string pData);
	void pop(std::string pData);
	void print();


private:
	bool isEmpty();
	bool isFull();
	void incHead(); // Queue Front/Head is the pop
	void incTail(); // Queue Back/Tail is the write


	int mHead;
	int mTail;
	int MAX_SIZE;
	std::string *QPtr;


};


#endif //_QARRAY_H

