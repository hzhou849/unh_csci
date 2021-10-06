
#include <iostream>
#include <String>
#include "QArray.h"

QArray::QArray(int pMaxSize)
{
	mHead = -1;
	mTail = -1;
	MAX_SIZE = pMaxSize;
	QPtr = new std::string[pMaxSize];

}


QArray::~QArray()
{
	std::cout << "Destructor called" << std::endl;
	delete[] QPtr;
}


bool QArray::isEmpty()
{
	return (mHead == -1);
}


void QArray::incTail()
{
	if (mTail == (MAX_SIZE - 1) && mHead != 0)
	{
		mTail = 0;
	}
	else if (mTail+1 != mHead)
	{
		mTail++;
	}
	else
		throw
}

void QArray::incHead()
{
	if (mHead == (MAX_SIZE - 1))
		mHead = 0;
	else
		mHead++;
}

bool QArray::isFull()
{
	// If  H -> T is the next cell, then we have hit MAX
	int headNextPos = mHead + 1;

	if (headNextPos == )

	if ( (MAX_SIZE-1) % mHead  )
	if (mTail = mHead+1 )
	
	return ()
}

void QArray::push(std::string pData)
{
	try
	{
		if (isFull())
			throw FullQueue();
	}
	catch (FullQueue& err)
	{
		exit(EXIT_FAILURE);
	}
	
	incHead();
	
}

