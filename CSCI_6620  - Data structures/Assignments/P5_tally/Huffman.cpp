/*
 * Huffman.cpp
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P5 Tally
 * Name:        HOWARD ZHOU - ID# 00748064
 */

#include <iostream>
#include "Huffman.h"


Huffman::Huffman() {}
Huffman::~Huffman() {}

Node* Huffman::getNode(char ch, int tally, Node *left, Node *right)
{
	Node *node = new Node();
	node->ch = ch;
	node->tally = tally;
	node->left = left;
	node->right = right;

	return node;
}


Node *Huffman::heapify(Node *root)
{
	// Create a leaf node for each of character and add it to the priority queue.
	// set the unordered_map to 
	for (auto pair : tally)
	{
		P5pq.push(getNode(pair.first, pair.second, nullptr, nullptr));
	}

	while (P5pq.size() != 1)
	{
		// Remove the two nodes of highest priority
		// In this case (lowest frequency/smallest numbers) from the queue 
		Node *left = P5pq.top();
		P5pq.pop();
		Node *right = P5pq.top();
		P5pq.pop();

		// Create a new node with these two nodes as children
		// and with frequency equal to the sum of the two node's
		// frequencies. Add the new node 

		int sum = left->tally + right->tally;
		P5pq.push(getNode('\0', sum, left, right));
		
	}

	root = P5pq.top();
	return *root;
}


void Huffman::doTally(std::string text)
{
	for (char ch : text)
	{
		tally[ch]++;
	}

	
}


// Traverse the Huffman Tree and store Huffman codes in a map
void Huffman::encode(Node * root, std::string str, std::unordered_map<char, std::string> &huffmanCode)
{
	if (root == nullptr)
	{
		return;		
	}

	// Found a left node, both left and right are null.
	if (!root->left && !root->right)
	{
		huffmanCode[root->ch] = str;
	}

	encode(root->left, str + "0", huffmanCode);
	encode(root->right, str + "1", huffmanCode);


}

// Recursively traverse the Huffman Tree and decode the encode string
void Huffman::decode(Node *root, int &index, std::string str)
{
	if (root == nullptr)
	{
		return;
	}

	// found a leaf node
	if (!root->left && !root->right)
	{
		std::cout << "Decoded string" << root->ch;
		return;
	}

	index++;

	if (str[index] == '0')
	{
		decode(root->left, index, str);
	}
	else
	{
		decode(root->right, index, str);
	}
}


// Build Huffman Tree. Decode given input text
void Huffman::compress(std::string text)
{
	doTally(text);

	rootHuffTree = heapify(rootHuffTree);

	// traverse the Huffman Tree and store Huffman codes 
	// in a map. Also prints them

	std::unordered_map<char, std::string> huffmanCode;
	encode(rootHuffTree, "", huffmanCode);
	std::cout << "Huffman Codes: " << std::endl;
	
	for (auto pair : huffmanCode)
	{
		std::cout << "pair.first" << std::endl;
	}

}
