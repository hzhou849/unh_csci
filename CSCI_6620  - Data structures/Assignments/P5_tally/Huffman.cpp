/*
 * Huffman.cpp
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P5 Tally
 * Name:        HOWARD ZHOU - ID# 00748064
 */

#include <iostream>
#include <iomanip>
#include <fstream>
#include "Huffman.h"


Huffman::Huffman() {}
Huffman::~Huffman() {}

Node* Huffman::createNode(char ch, int tally, Node *left, Node *right)
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
	int counter = 0;

	std::cout << "Tally: " << std::endl;
	for (auto pair : tally)
	{
		std::cout << counter << " " << pair.first << " - " << pair.second << std::endl;
		P5pq.push(createNode(pair.first, pair.second, nullptr, nullptr));
		counter++;
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
		P5pq.push(createNode('\0', sum, left, right));
		
	}

	root = P5pq.top();
	return root;
}

// Tally up the characters in the string
void Huffman::doTally(std::string text)
{
	for (char ch : text)
	{
		tally[ch]++;     // Increment the unordered map stores of each character
	}
}


// Traverse the Huffman Tree and store Huffman codes in a map
void Huffman::encode(Node * root, std::string str, std::unordered_map<char, std::string> &huffmanCode)
{
	if (root == nullptr)
	{
		return;		
	}

	// Found a leaf node, both left and right are null.
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
		std::cout << root->ch;
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
	std::ofstream outputFile("HuffmanCodes.txt", std::ios::trunc);
	std::ofstream outputFileES("EncodedString.txt", std::ios::trunc);

	doTally(text);

	rootHuffTree = heapify(rootHuffTree);
	GuiPrint(rootHuffTree);

	// traverse the Huffman Tree and store Huffman codes 
	// in a map. Also prints them

	std::unordered_map<char, std::string> huffmanCode;
	encode(rootHuffTree, "", huffmanCode);
	std::cout << "Huffman Codes: " << std::endl;
	outputFile<< "Huffman Codes: " << std::endl;
	 
	
	for (auto pair : huffmanCode)
	{
		std::cout  << pair.first << " "  << pair.second <<  std::endl;
		outputFile << pair.first << " "  << pair.second <<  std::endl;
	
	}

	std::cout << "\nOriginal string was: " << text << std::endl;

	// print encoded string
	std::string str = "";
	for (char ch : text)
	{
		str += huffmanCode[ch];
	}

	std::cout << "Encoded string: " << str << std::endl;
	outputFileES << str;

	// Traverse the Huffman tree again an this time decode the encoded string
	std::cout << "Decoded String: ";

	int index = -1;
	while (index < (int)str.size() - 2)
	{
		decode(rootHuffTree, index, str);
	} 

	outputFile.close();
	outputFileES.close();

}


void Huffman::GuiPrint(Node *root, int indent)
{
	// Check if this goes back?
	if (root == nullptr)
	{
		return;
	}

	if (indent == rootIndent && !rootPrinted)
	{
		if (root->left->ch == '\0')
			std::cout << std::setw(indent) << "(" << root->tally << ")" << std::endl;
		else
			std::cout << std::setw(indent) << root->ch << ";" << root->tally << std::endl;
	}

	// Parent has a left and right node.
	if (root->right && root->left)
	{
		std::cout << std::setw(indent + 2) << " /   \\" << std::endl;
		std::cout << std::setw(indent - 3);
		if (root->left->ch == '\0')
			std::cout << "(" << root->left->tally << ")";
		else
			std::cout << root->left->ch << ";" << root->left->tally;

		if (root->right->ch == '\0')
			std::cout << std::setw(4) <<  "(" << root->right->tally << ")";
		else
			std::cout << std::setw(4) << root->right->ch << ";" << root->right->tally;
	}
	else if (root->right)	// Right leaf
	{
		std::cout << std::setw(indent + 3) << ' ' << "*\\\n";
		std::cout << std::setw(indent + 3) << ' ';

		std::cout << root->right->ch << ";" << root->tally << std::endl;
	}
	else if (root->left != nullptr)
	{
		std::cout << std::setw(indent - 1) << "/" << std::endl;
		std::cout << std::setw(indent - 2);
		std::cout << root->left->ch << ";" << root->left->tally << std::endl;
	}
	std::cout << std::endl;

	GuiPrint(root->left, indent - 2);
	GuiPrint(root->right, indent + 4);
}