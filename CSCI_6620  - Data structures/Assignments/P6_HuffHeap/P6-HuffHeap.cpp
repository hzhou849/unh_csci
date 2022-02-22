/*
 * P6_HuffHeap.cpp : This file contains the 'main' function. Program execution begins and ends there.
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P6 HuffHeap
 * Name:        HOWARD ZHOU - ID# 00748064
 */

#include <iostream>
#include <exception>
#include <fstream>
#include <string>

#include "Huffman.h"

void banner()
{
	std::cout << "------- Welcome to Program 6 HuffHeap by [ Howard Zhou ]! -------- -\n\n";
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
	exit(EXIT_FAILURE);
}



int main()
{
	std::ifstream inputFile;
	std::string stringData;

	banner();
	
	try
	{
		// Load the input file
		inputFile.open("P6_input.txt", std::ios::in);

		if (!inputFile)
			throw std::iostream::failure("Input file initialization error.");
	}
	catch (std::iostream::failure &err)
	{
		std::cerr << "Exception caught: " << err.what() << std::endl;
		fatal();
	}

	getline(inputFile, stringData);
	//std::cout << "STRING: [" << stringData << "]" << std::endl;

	Huffman huffObj;
	huffObj.compress(stringData);

	// Cleanup
	inputFile.close();

	bye();


}

