/*
 * Huffman.cpp
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P6 Huffman Heap
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

	// Build the Huffman tree
	rootHuffTree = heapify(rootHuffTree, outputFile);

	std::cout << std::setw(50) << "Huffman Tree:\n" << std::endl;
	GuiPrint(rootHuffTree);

	// traverse the Huffman Tree and store Huffman codes 
	// in a map. Also prints them

	std::unordered_map<char, std::string> huffmanCode;
	encode(rootHuffTree, "", huffmanCode);
	std::cout  << "\nHuffman Codes: " << std::endl;
	outputFile << "\nHuffman Codes: " << std::endl;
	 
	
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

// Print branches for the Huffman Tree
void prBranchLR(int width, int tierCount)
{
	switch (tierCount)
	{
	case 0:
		std::cout << std::setw(width) << "/" << std::setw(10) << "\\";
		break;
	case 1:
		std::cout << std::setw(width-1) << "         /" << std::setw(11 ) << "\\";
		break;
	case 2:
		std::cout << std::setw(width+4) << "      /     \\";
		break;
	}
}


// Helper function to print nodes on the huffman tree
void prNumNode(int tally, int width, int tierCount, bool overrideWidth = false)
{
	switch(tierCount)
	{
	case 0:
		if (overrideWidth == true)
			width = 12;
		std::cout << std::setw(width) << "(" << tally << ")";
		break;
	case 1:
		if (overrideWidth == true)
		{
			width = 8;
		}
		std::cout << std::setw(width+1) << "(" << tally << ")";
		break;
	case 2:
		std::cout << std::setw(width) << " (" << tally << ") ";
		break;
	case 3:
		std::cout << std::setw(width) << "(" << tally << ")";
		break;
	default:
		std::cout << std::setw(1) << "(" << tally << ")";
		break;

	}


}



void Huffman::GuiPrint(Node *root, int indent)
{
	int offset_indent = 4;		// Adjust as needed
	int offset_indent2 = 5;
	int offset_indent3 = 3;
	Node *tempNode = nullptr;
	
	if (tierCount == 4)
		vRightList.pop();

	if (root == nullptr)
	{
		//std::cerr << "Root pointer is NULL" << std::endl;
		return;
	}

	// This is the root character node being printed
	if ( indent == rootIndent && !rootPrinted)
	{
		rootPrinted = true;
		if ((root->left != nullptr) && (root->left->ch == '\0'))  // the end has been reached, 
			std::cout << std::setw(indent) << "(" << root->tally << ")" << std::endl;
		else if (root->right != nullptr)
			std::cout << std::setw(indent) <<"{" <<root->ch << "; " << root->tally << "}" << std::endl;
	}

	// Parent has a left and right node.
	if (root->right && root->left)
	{
		prBranchLR(indent-offset_indent, tierCount);

		// **Check prevRootRight Node
		if (rootRight != nullptr)
		{
			for (int i = 0; i < vRightList.size(); i++)
			{
				if (rootRight->left && rootRight->right) // Left leaf
					prBranchLR(offset_indent + 3, tierCount);
			}
		}
		std::cout << std::endl;

		/* SET THE NEW LINE INDENT FOR THIS TIER*/
		std::cout << std::setw(indent - 6);
		current_indent = indent - 7;


		if (root->left->ch == '\0') // Node is a tally node
			prNumNode(root->left->tally, current_indent, tierCount);
		else
			std::cout << "[" <<root->left->ch << ";" << root->left->tally << "]";

		// Print the RIGHT tally node
		if (root->right->ch == '\0')
		{
			if (tierCount == 0 )
				prNumNode(root->right->tally, 10, tierCount);
			else
				prNumNode(root->right->tally, 5, tierCount);
			rootRight = root->right;
		}
		else
			std::cout << "["  << root->right->ch << ";" << root->right->tally << "]";


		// **Check prevRootRight Node - print node
		if (!vRightList.empty())
		{	

			curQueSize = vRightList.size();
			vRightList.push(rootRight);
			for (int i=0; i < curQueSize; i++)
				hPrint(vRightList.front());
		}
		else
			vRightList.push(rootRight);

		std::cout << std::endl;
	}
	else if (root->right)		// Right leaf
	{
		std::cout << std::setw(indent + offset_indent) << ' ' << "*\\\n";
		std::cout << std::setw(indent - offset_indent);
		std::cout <<"[" << root->right->ch << ";" << root->right->tally << "]";
		std::cout << std::endl;
	}
	else if (root->left != nullptr) // Left leaf
	{
		std::cout << std::setw(indent - 1) << "/" << std::endl;
		std::cout << std::setw(indent - offset_indent3);
		std::cout << "[" << root->left->ch << ";" << root->left->tally << "]" << std::endl;;
	}	

	tierCount++;
	std::cout << std::endl;

	GuiPrint(root->left, indent - offset_indent);
}


void Huffman::hPrint(Node *targetNode)
{	
	if (targetNode == nullptr)
	{
		vRightList.pop();
		return;
	}
	else
	{
		if (targetNode->left != nullptr && targetNode->left->ch == '\0')
		{
			prNumNode(targetNode->left->tally, 3, tierCount, true);
			vRightList.push(targetNode->left);
		}
		else 
			if (targetNode->left != nullptr)
				std::cout << " [" << targetNode->left->ch << ";" << targetNode->left->tally << "]";

		if (targetNode->right != nullptr && targetNode->right->ch == '\0')
		{
			prNumNode(targetNode->right->tally, 3, tierCount, true);
			vRightList.push(targetNode->right);
		}	
		else
			if (targetNode->right != nullptr)
				std::cout << " [" << targetNode->right->ch << ";" << targetNode->right->tally << "]";

		vRightList.pop();
		

	}
}