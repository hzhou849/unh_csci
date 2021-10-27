
#ifndef _TREE_H
#define _TREE_H
#pragma once


#include <iostream>
#include "Node.h"

class Tree
{
public:
	Tree();
	~Tree();

	// Copy Constructor - Deep Copy
	// It is critical that tree be a reference parameter
	Tree(const Tree &inObjTree);

	// Overload the '=' operator for copying?
	/*void operator=(Tree &inObjTree);*/

	void MakeEmpty();
	bool IsEmpty() const;
	bool IsFull() const;
	int GetLength() const;

	int GetItem(int item, bool *found);
	void PutItem(int item);
	void DeleteItem(int item);
	void ResetTree();
	void Print() const;
	void PrintTree(Node *pTree);
	Node *getRoot();

	void GuiPrint(Node *pTree);


private:
	Node *root; // Similar to head of linked list
};
#endif // !_TREE_H


/* Implementation */
Tree::Tree(): root(nullptr) 
{
}

Tree::~Tree()
{
	std::cerr << "Destructor called" << std::endl;
}

Node* Tree::getRoot()
{
	return root;
}


bool Tree::IsFull() const
{
	Tree *location;

	try
	{
		location = new Tree;
		delete location;

		return false;
	}
	catch (std::bad_alloc exception)
	{
		return true;
	}
}

bool Tree::IsEmpty() const
{
	return root == nullptr;
}


int countNodes(Node *pTree)
{
	if (pTree == nullptr)
		return 0;
	else
		// Total Left tree + Total Right tree + 
		return ( countNodes(pTree->mLeftNode) + countNodes(pTree->mRightNode) + 1);
}

int Tree::GetLength() const
{
	return countNodes(root);
}

// Helper function is not a class member to make recursion easier to implement since you 
// cannot pass the address of the node so easily from the main calling class.
void Insert(Node *&pTree, int pItem)
{
	// Insertion place found. Create a new leaf node.
	if (pTree == nullptr)
	{
		pTree = new Node(pItem);
		// Default pointers for LEFT and RIGHT are already null.
	}
	else if (pItem < pTree->mData)		// If item is smaller than root, insert LEFT
	{
		Insert(pTree->mLeftNode, pItem);
	}
	else
	{
		Insert(pTree->mRightNode, pItem);	// If item is larger, insert RIGHT
	}


}

void Tree::PutItem(int pItem)
{
	Insert(root, pItem);
}


// Prints info member of items in tree in sorted order.
void Tree::PrintTree(Node *pTree)
{
	if (pTree != nullptr)
	{
		PrintTree(pTree->mLeftNode);  // Print the LEFT substree.
		std::cout << pTree->mData << std::endl;
		PrintTree(pTree->mRightNode); // Print the RIGHT subtree.
	}
}


void Tree::GuiPrint(Node *pTree)
{
	if (pTree != nullptr)
	{
		std::cout << pTree->mData << std::endl;
		GuiPrint(pTree->mLeftNode);
		GuiPrint(pTree->mRightNode);
	}
}