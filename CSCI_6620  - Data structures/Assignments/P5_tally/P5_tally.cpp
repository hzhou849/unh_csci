/*
 * P5_tally.cpp : This file contains the 'main' function. Program execution begins and ends there.
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P5 Tally
 * Name:        HOWARD ZHOU - ID# 00748064
 */

#include <iostream>
#include <string>



#include "Huffman.h"

void banner()
{
	std::cout << "------- Welcome to Program 5 Meany by [Howard Zhou]! -------- -\n\n";
	std::cout << "My Major is Computer Science		Graduation Year : 2023\n\n";
	std::cout << "\"Loyalty is a two way street. If I'm asking it from you then you already got it from me.\"\n- Harvey Specter, Suits.\n\n";
	std::cout << "About Me : Former Paratrooper in the Army; I work in the field of robitics as a software engineer.\n\n";
	std::cout << "Interests: Traveling, hiking and swimming\n";
	std::cout << "--------------------------------------------------------------------\n\n" << std::endl;
}

void bye()
{
	std::cout << "\nProgram ran successfully - goodbye!" << std::endl;
}


void fatal()
{
	std::cerr << "Fatal error detected. Terminating program." << std::endl;
}


struct comp
{
	bool operator() (int nOne, int nTwo)
	{
		// highest priority item has lowest frequency
		return nOne > nTwo;
	}
};


int main()
{
	int left;
	int right;
	int count = 0;
	banner();
	
	//Huffman huffm;



	//std::priority_queue<int, std::vector<int >, comp> pq;

	//pq.push(5);
	//pq.push(10);
	//pq.push(20);
	//pq.push(2);

	//while (!pq.empty())
	//{
	//	std::cout << pq.top() << std::endl;
	//	pq.pop();

	//}

	//while (pq.size() != 1)
	//{
	//	std::cout << "Iteration: " << count << std::endl;
	//	left = pq.top();
	//	std::cout << "Left:" << pq.top() << std::endl;
	//	pq.pop();
	//	std::cout << "Right:" << pq.top() << std::endl;
	//	right = pq.top();
	//	pq.pop();

	//	int sum = left + right;
	//	std::cout << "sum: " << sum << "\n" << std::endl;
	//	
	//	pq.push(sum);
	//	count++;


	//}

	Huffman huffObj;
	huffObj.compress("aabacdab");

	bye();


}

