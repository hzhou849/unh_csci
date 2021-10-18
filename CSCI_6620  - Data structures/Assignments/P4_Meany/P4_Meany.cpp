/*
 * P4_Meany.cpp : This file contains the 'main' function. Program execution begins and ends there.
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P4 Meany
 * Name:        HOWARD ZHOU - ID# 00748064
 */




// Setup
// x1. Call banner().Then open the late file properly and fill the list with Cells, each containing one names from the file.
// x2. Instantiate your CList class, which should be initially empty.
//x 3. Open the file and attempt to read the first line(two names, separated by a space).
// 4. If there are zero names in the file, end the program immediately with a congratulatory comment.
// 5. Otherwise, read the file, one student at a time, install the student in a new Cell, and attach 
//		the new Cell to the tail end of the list.Count the cells you create.
// 6. When eof is reached, close the file and make the last Cell on the list point back to the first one, forming a circle.

// 1. If there is exactly one name in the file, end the program immediately with a comment announcing the loser.
// 2. Otherwise, set a pointer(current) to the first student on the list.
// 3. Use a string library function to get N, the length of the current last name.
// 4. Walk around the circular list for N steps and look at the seen flag for that student.The first student who was 
//		previously is the loser.Announce his name and end the process.
// 5. Otherwise, mark the current student as seen.
// 6. Repeat this process from step 3. Properly free all dynamic memory.
// 7.Call bye().




#include <iostream>
#include <exception>
#include <fstream>
#include <sstream>
#include <string>

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
	
	// x1. Call banner().Then open the late file properly and fill the list with Cells, each containing one names from the file.

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


// x2. Instantiate your CList class, which should be initially empty.
// x3. Open the file and attempt to read the first line(two names, separated by a space).
// 
// 4. If there are zero names in the file, end the program immediately with a congratulatory comment.
// 5. Otherwise, read the file, one student at a time, install the student in a new Cell, and attach 
//		the new Cell to the tail end of the list.Count the cells you create.
// 6. When eof is reached, close the file and make the last Cell on the list point back to the first one, forming a circle.

	// Initialize the list by creating the head.
	Student *headStudent= new Student("NULL", "NULL");
	myList.insert(headStudent);

	std::string fName;
	std::string lName;

	while (getline(inputFile, strData))
	{
		
		//Method 1
		// seperate out the two names
		//for (auto tempStr: strData)
		//{
		//	std::cout << "string: " << tempStr << std::endl;
		//}
		//std::cout << "--------------------------" << std::endl;

		// Method 2 word parser:
		std::stringstream ss(strData);
		ss >> fName >> lName;
		std::cout << "fName: " << fName << " lName: " << lName << std::endl;
		Student *newStudent = new Student(fName, lName);


		myList.insert(newStudent);

	}

	myList.print();

	inputFile.close();
	outputFile.close();

	bye();
}


