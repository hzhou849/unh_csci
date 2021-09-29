/*
 * Filename: p3_little_dog_part1.cpp
 * 
 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 1
 * HOWARD ZHOU  - ID# 00748064
 *
 * 
 * - Implement a main function with a command-line argument that does these things:
 * - Call banner() at the beginning of your program and bye() at the
 * - Instantiate the List class
 * - Open and read in the file named by the command-line argument. Handle eof properly.  If there are any problems, call fatal)().
 * - The input file contains a series of lines of text. Do not modify my file in order to make your program work. Do not remove the newline character on the end of the last line.
 * - Use List::insert() to insert each line of the file into the List. (This is a linked-list insertion sort.)
 * - Call bye() before you return from
 * 
 * Questions:
 * 1) should the printout be the order of the linked list. Backwards?
 * 2) find function? mPrior or mScan?
 * 3) do you want me to print the head node or start from head->next?
 * 
 */
#include <iostream>
#include <fstream>
#include <string>
#include <exception>

#include "List.h"



void banner()
{
	std::cout << "------ - Welcome to Program 3 LITTLE DOG by[Howard Zhou]!-------- -\n\n";
	std::cout << "My Major is Computer Science		Graduation Year : 2023\n\n";
	std::cout << "\"Loyalty is a two way street.If I'm asking it from you then you already got it from me.\"\n- Harvey Specter, Suits.\n\n";
	std::cout << "About Me : Former Paratrooper in the Army; I work in the field of robitics as a software engineer.\n\n";
	std::cout << "Interests: Travel, hiking and Swimming\n\n" << std::endl;

}


void bye()
{
	std::cout << "Exiting program - Bye!" << std::endl;
}

void fatal()
{
	exit( EXIT_FAILURE);
}


int main()
{
	int counter = 0;
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
			throw std::iostream::failure("I/O File ERROR");
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
		counter++;
	}

	// Print the list
	myList.print(outputFile);

	// Close the iostreams
	inputFile.close();
	outputFile.close();

	bye();
}

