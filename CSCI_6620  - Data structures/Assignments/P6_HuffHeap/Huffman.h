/*
 * Huffman.h
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P6 Huffman Heap
 * Name:        HOWARD ZHOU - ID# 00748064
 */


#ifndef _HUFFMAN_H
#define _HUFFMAN_H
#pragma once

#include <unordered_map>
#include <vector>
#include <queue>
#include "Node.h"


static const int rootIndent = 40;  // Adjust spacing if needed

class Huffman
{

public:
	Huffman();
	~Huffman();
	Node *createNode(char ch, int tally, Node *left, Node *right);
	Node *heapify(Node *root, std::ofstream &outputFile);
	void compress(std::string text);

private:
	void doTally(std::string text);
	void encode(Node * root, std::string str, std::unordered_map<char, std::string> &huffmanCode);
	void decode(Node *root, int &index, std::string str, std::string &decodedStr);


	struct comp // Comparator helper function for priority_queue()
	{
		bool operator()(Node *nOne, Node *nTwo)
		{
			// highest priority item has lowest frequency
			return nOne->tally > nTwo->tally;
		}
	};

	
	void GuiPrint(Node *root, int indent=rootIndent);

	// Member variables
	bool rootPrinted = false;
	std::unordered_map<char, int> tally;
	std::priority_queue<Node*, std::vector<Node*>, comp> P5pq;
	std::queue<Node*> vRightList;
	Node *rootHuffTree	= new Node();
	Node *prevRootRight = nullptr;
	Node *rootRight		= nullptr;
	void hPrint(Node *targetNode);
	int curQueSize	= 0;
	int tierCount	= 0;
	int current_indent = 0;
};



#endif //_HUFFMAN_H

