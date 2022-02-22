
#ifndef _NODE_H
#define _NODE_H
#pragma once



class Node
{
public:
	Node(int pValue, Node *pLeft = nullptr, Node *pRight = nullptr) : mData(pValue), mLeftNode(pLeft), mRightNode(pRight) {}
	~Node() {}

	int mData;
	Node *mLeftNode;
	Node *mRightNode;

};

#endif // !_NODE_H
