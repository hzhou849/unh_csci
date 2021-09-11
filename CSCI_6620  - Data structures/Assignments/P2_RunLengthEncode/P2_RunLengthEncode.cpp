// CSCI_6620 - Data Structure
// Professor Thomas Shokite
// 
// CSCI_6620-P2_Run_Length_ENCODE.cpp - Assignment 2
// 
// HOWARD ZHOU  - ID# 00748064

#include <iostream>
#include <string>
#include <fstream>

int main()
{

	char prevChar;
	char currChar;
	char escapeChar = 0x7F; // '\x7F'
	short int runCount = 0;

	// Load the input file and create the output file.
	std::ifstream inFile("uncompressed.txt", std::ios::in);
	std::ofstream outFile("console_out.ext", std::ios::trunc);

	if (!inFile)
	{
		std::cerr << "Input file descriptor initialization failed." << std::endl;
		return EXIT_FAILURE;
	}


}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
