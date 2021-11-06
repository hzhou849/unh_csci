/*
 * Huffman.h
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P5 Tally
 * Name:        HOWARD ZHOU - ID# 00748064
 */


#ifndef _HUFFMAN_H
#define _HUFFMAN_H
#pragma once


#include <unordered_map>
#include <queue>

#include "Node.h"


class Huffman
{

public:
	Huffman();
	~Huffman();
	Node *getNode(char ch, int tally, Node *left, Node *right);
	Node heapify(std::string text, Node *root);


private:
	
	struct comp
	{
		bool operator()(Node *nOne, Node *nTwo)
		{
			// highest priority item has lowest frequency
			return nOne->tally > nTwo->tally;
		}
	};

	
	std::unordered_map<char, int> tally;

	std::priority_queue<Node*, std::vector<Node*>, comp> P5pq;
	Node *rootHuffTree = new Node();
	



};


#endif //_HUFFMAN_H

