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


Node *Huffman::heapify(Node *root, std::ofstream &outputFile)
{
	// Create a leaf node for each of character and add it to the priority queue.
	// set the unordered_map to 

	std::cout  << "\nTally: " << std::endl;
	outputFile << "\nTally: " << std::endl;
	
	for (auto pair : tally)
	{
		if (pair.first == ' ')
		{
			/* For hex output of special characters uncomment this block */
			//std::cout << counter << " " << std::hex << std::showbase << static_cast<std::uint16_t>(pair.first) << " - "; 
			//std::cout << std::resetiosflags(std::ios::basefield); // Reset the io flags to default and print decimal
			//std::cout << pair.second << std::endl;

			std::cout << " '" << pair.first << "'- " << pair.second << std::endl;
			outputFile << " '" << pair.first << "'- " << pair.second << std::endl;
		}
		else
		{
			std::cout << "  " << pair.first << " - " << pair.second << std::endl;
			outputFile << "  " << pair.first << " - " << pair.second << std::endl;
		}
		P5pq.push(createNode(pair.first, pair.second, nullptr, nullptr));
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
void Huffman::doTally(std::string text )
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
void Huffman::decode(Node *root, int &index, std::string str, std::string &decodedStr)
{
	if (root == nullptr)
	{
		return;
	}

	// found a leaf node
	if (!root->left && !root->right)
	{
		std::cout << root->ch;
		decodedStr += root->ch;
		return;
	}

	index++;

	if (str[index] == '0')
	{
		decode(root->left, index, str, decodedStr);
	}
	else
	{
		decode(root->right, index, str, decodedStr);
	}
}


// Build Huffman Tree. Decode given input text
void Huffman::compress(std::string text)
{
	std::ofstream outputFile("HuffmanCodes.txt", std::ios::trunc);
	std::string decodedStr = "";

	doTally(text);

	rootHuffTree = heapify(rootHuffTree, outputFile);

	// traverse the Huffman Tree and store Huffman codes 
	// in a map. Also prints them

	std::unordered_map<char, std::string> huffmanCode;
	encode(rootHuffTree, "", huffmanCode);
	std::cout << "\nHuffman Codes: " << std::endl;
	outputFile<< "\nHuffman Codes: " << std::endl;
	 
	
	for (auto pair : huffmanCode)
	{
		std::cout  << pair.first << " "  << pair.second <<  std::endl;
		outputFile << pair.first << " "  << pair.second <<  std::endl;
	}

	std::cout << "\nOriginal string was: " << text  << "\n"<< std::endl;
	outputFile << "\nOriginal string was: " << text << "\n" << std::endl;


	// print encoded string
	std::string str = "";
	for (char ch : text)
	{
		str += huffmanCode[ch];
	}

	std::cout << "Encoded string: " << str << std::endl;
	outputFile << "Encoded string:" << str << std::endl;

	// Traverse the Huffman tree again an this time decode the encoded string
	std::cout << "\nDecoded String: ";
	outputFile << "\nDecoded String: ";


	int index = -1;
	while (index < (int)str.size() - 2)
	{
		decode(rootHuffTree, index, str, decodedStr);
	} 
	outputFile << decodedStr << std::endl;

	outputFile.close();

}

