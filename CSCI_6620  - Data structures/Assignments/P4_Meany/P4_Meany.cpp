/*
 * P4_Meany.cpp : This file contains the 'main' function. Program execution begins and ends there.
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P4 Meany
 * Name:        HOWARD ZHOU - ID# 00748064
 */

#include <iostream>
#include <exception>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#include "CList.h"
#include "Student.h"



void banner()
{
	std::cout << "------- Welcome to Program 4 Meany by [Howard Zhou]! -------- -\n\n";
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


int main()
{
	// Local Variables:
	CList myList;
	std::string strData;
	std::ifstream inputFile;
	std::ofstream outputFile;
	
	// Print the banner
	banner();

	// Open the late.txt file and fill list with Cells.
	try
	{
		inputFile.open("late.txt", std::ios::in);
		outputFile.open("console_out.txt", std::ios::trunc);

		if (!inputFile || !outputFile)
			throw std::iostream::failure("I/O File initialization error.");
	}
	catch (std::iostream::failure &err)
	{
		std::cerr << "I/O exception caught \n" << err.what() << std::endl;
		fatal();
	}

	// Initialize the list by creating the head.
	Student *headStudent= new Student("NULL", "NULL");
	myList.insert(headStudent);

	std::string fName;
	std::string lName;

	int count = 0;

	while (getline(inputFile, strData))
	{
		std::stringstream ss(strData);
		ss >> fName >> lName;
		Student *newStudent = new Student(fName, lName);
		myList.insert(newStudent);
		count++;
	}
	
	if (count == 0)
	{
		std::cout  << "Congratulations, there are NO losers found." << std::endl;
		outputFile << "Congratulations, there are NO losers found." << std::endl;
	}
	else if (count == 1)
	{
		std::cout  << "The ONE loser found is: " << std::endl;
		outputFile << "The ONE loser found is: " << std::endl;
		myList.print(outputFile);
		myList.memCleanup();		// Cleanup all dynamic heap allocation memory
	}
	else
	{
		myList.closeList();
		myList.print(outputFile);
		myList.pickLoser(outputFile);
		myList.memCleanup();

	}

	// Close file descriptors
	inputFile.close();
	outputFile.close();

	bye();
}


