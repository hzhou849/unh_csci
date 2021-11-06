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


Node Huffman::heapify(std::string text, Node *root)
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
		// (lowest frequency) from the queue 
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