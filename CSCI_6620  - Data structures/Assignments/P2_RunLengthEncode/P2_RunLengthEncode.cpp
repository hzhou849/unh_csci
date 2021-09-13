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
	std::ifstream inFile("uncompressed.txt", std::ios::in); //********************Change this input file
	std::ofstream outFile("console_out.ext", std::ios::trunc | std::ios::binary);

	if (!inFile)
	{
		std::cerr << "Input file descriptor initialization failed." << std::endl;
		exit(EXIT_FAILURE);
	}
	if (!outFile)
	{
		std::cerr << "Output file descriptor initialization failed." << std::endl;
		exit(EXIT_FAILURE);
	}

	//outFile << escapeChar << static_cast<std::uint8_t>(runCount) << someChar << std::flush;

	// Load the first character of this iteration into previousChar
	runCount++;
	inFile.get(prevChar);		
	
	int wcount = 0;
	while ( !inFile.eof() )
	{
		inFile.get(currChar);		// Read the next character into currentChar

		/*if (currChar == 'w')
		{
			std::cout << "\nW FOUND: [" << currChar << ']' << std::flush;
			wcount++;
		}*/
		if ( prevChar == currChar )
		{
			if (runCount == 255)	// If runCount of 255(0xFF) has been reached write a triplet set (Esc, char, count)
			{
				std::cout << escapeChar << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
				outFile << escapeChar << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
				runCount = 1;
			}
			else if ( !inFile.eof() ) // ammend depending on output of EOF handling
			{
				
				runCount++;
			}
		}

		else
		{
			if (runCount < 4 )
			{
				// Write the character x runCount
				for (short int i = 0; i < runCount; i++)
				{
					std::cout << prevChar << std::flush;
					outFile << prevChar << std::flush;
					wcount = 0;
				}

			}
			else // runCount is 4 or more, writing triplet
			{
				std::cout << escapeChar  << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
				outFile << escapeChar  << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
			}
			runCount = 1;		// Reinitialize runcounter to 1;

		}

		prevChar = currChar;		// Assign the current character to the previous character

	}

	// Dump the remainder of the buffer after EOF is detected
	for (short int i = 0; i < runCount; i++)
	{
		std::cout << prevChar << std::flush;
		outFile << prevChar << std::flush;
	}

	outFile.close();


}


//In this scheme, any “run” of the same character(4 or more identical consecutive bytes) is replaced by a triplet of bytes, consisting of
//
// 1) An escape character. We will use 0x7f, which is sometimes called “esc”.It is a non - printing ASCII character
// 2) The letter that has been repeated
// 3) A 1 - byte count = the number of repetitions 
//    To make this work, any esc character, or run of them, that occurs 
//	  in the input must also be replaced by a triplet : esc esc count .

//	If the input file contains no “esc” characters :
//		1) If one or more runs of length 4 or more exist : the output file will be shorter
//		2) If the file contains no runs of length 4 or more : the output will be identical to the input file
//	If the input file contains runs of 1 or 2 “esc” characters, the output file will be longer unless those short runs are balanced by longer runs