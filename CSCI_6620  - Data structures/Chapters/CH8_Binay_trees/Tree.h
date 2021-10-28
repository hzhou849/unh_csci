
#ifndef _TREE_H
#define _TREE_H
#pragma once


#include <iostream>
#include <iomanip>
#include "Node.h"

static const int rootIndent = 20;


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

	void GuiPrint(Node *pTree, int indent = rootIndent);


private:
	Node *root; // Similar to head of linked list
	bool rootPrinted = false;
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
	else if (pItem <= pTree->mData)		// If item is smaller than root, insert LEFT
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



// Modify the print to start looking into priors?
void Tree::GuiPrint(Node *pTree, int indent)
{
	if (pTree != nullptr)
	{
		if (indent == rootIndent && !rootPrinted)
		{
			std::cout << std::setw(indent) << pTree->mData << std::endl;
			rootPrinted = true;
		}


		if (pTree->mRightNode && pTree->mLeftNode)
		{
			std::cout << std::setw(indent+2) << "/   \\" << std::endl;
			std::cout << std::setw(indent - 3); 
			std::cout << pTree->mLeftNode->mData;
			std::cout <<std::setw(6) <<  pTree->mRightNode->mData;
		}
		else if (pTree->mRightNode)
		{
			std::cout << std::setw(indent+3) << ' ' << "*\\\n";
			std::cout << std::setw(indent+3) << ' ';
			std::cout << pTree->mRightNode->mData << std::endl;
		}
		else if (pTree->mLeftNode != nullptr)
		{
			std::cout << std::setw(indent-1) << "/" << std::endl;
			std::cout << std::setw(indent - 2);
			std::cout << pTree->mLeftNode->mData << std::endl;
		}
		std::cout << std::endl;

		GuiPrint(pTree->mLeftNode, indent-2);
		GuiPrint(pTree->mRightNode, indent+4);

		//GuiPrint(pTree->mLeftNode->);
		//GuiPrint(pTree->mRightNode);
	}
}