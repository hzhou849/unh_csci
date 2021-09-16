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

	// Load the first character of this iteration into previousChar
	runCount++;
	inFile.get(prevChar);		
	
	int wcount = 0;
	while ( !inFile.eof() )
	{
		inFile.get(currChar);		// Read the next character into currentChar

		if ( prevChar == currChar )
		{
			if (runCount == 255)	// If runCount of 255(0xFF) has been reached write a triplet set (Esc, char, count)
			{
				std::cout << escapeChar << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
				outFile   << escapeChar << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
				runCount = 1;
			}
			else
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
					outFile   << prevChar << std::flush;
					wcount = 0;
				}

			}
			else // runCount is 4 or more, writing triplet
			{
				std::cout << escapeChar  << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
				outFile   << escapeChar  << prevChar << static_cast<std::uint8_t>(runCount) << std::flush;
			}
			runCount = 1;
		}

		prevChar = currChar;		// Assign the current character to the previous character

	}

	// Dump the remainder of the buffer after EOF is detected
	for (short int i = 0; i < runCount; i++)
	{
		std::cout << prevChar << std::flush;
		outFile   << prevChar << std::flush;
	}

	// Close out file descriptors
	inFile.close();
	outFile.close();	
	
	return EXIT_SUCCESS;
}
