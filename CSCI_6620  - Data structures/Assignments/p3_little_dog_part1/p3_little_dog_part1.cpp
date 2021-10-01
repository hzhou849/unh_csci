/*
 * Filename: p3_little_dog_part1.cpp
 * 
 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 1
 * HOWARD ZHOU  - ID# 00748064
 *
 */
#include <iostream>
#include <fstream>
#include <string>
#include <exception>

#include "List.h"



void banner()
{
	std::cout << "------- Welcome to Program 3 LITTLE DOG by [Howard Zhou]! -------- -\n\n";
	std::cout << "My Major is Computer Science		Graduation Year : 2023\n\n";
	std::cout << "\"Loyalty is a two way street. If I'm asking it from you then you already got it from me.\"\n- Harvey Specter, Suits.\n\n";
	std::cout << "About Me : Former Paratrooper in the Army; I work in the field of robitics as a software engineer.\n\n";
	std::cout << "Interests: Traveling, hiking and swimming\n";
	std::cout << "--------------------------------------------------------------------\n\n" << std::endl;
}


void bye()
{
	std::cout << "\nProgram ran successfully - Bye!" << std::endl;
}


void fatal()
{
	std::cerr << "Fatal Error detected. Terminating Program." << std::endl;
	exit( EXIT_FAILURE);
}


int main()
{
	List myList;
	std::string strData;
	std::ifstream inputFile;
	std::ofstream outputFile;
	
	// Print the banner
	banner(); 

	try
	{
		//Load the input file and create an output file.
		inputFile.open("p3Meow.txt", std::ios::in);
		outputFile.open("console_out.txt", std::ios::trunc);

		if (!inputFile || !outputFile)
			throw std::iostream::failure("I/O File Initialization error.");
	}
	catch (std::iostream::failure& err)
	{
		std::cerr << "I/O exception caught \n" << err.what() << std::endl;
		fatal();
	}

	// Initialize the list by creating the head
	myList.insert("This is the head. Data NOT USED.");

	// Read each line of the input text file
	while (getline(inputFile, strData))
	{
		myList.insert(strData);
	}

	// Print the list
	myList.print(outputFile);

	inputFile.close();
	outputFile.close();

	bye();
}

