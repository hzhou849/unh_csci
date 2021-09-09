// CSCI_6620 - Data Structure
// Professor Thomas Shokite
// 
// CSCI_6620-P1_run_length_decode.cpp - Assignment 1
// 
// HOWARD ZHOU  - ID# 00748064

#include <iostream>
#include <string>
#include <fstream>


int main()
{
    char charBuffer = 0;
    char my_character = 0;
    char num_reps = 0;

    
    // Load the input file
    std::ifstream inFile("compressed1.txt", std::ios::in );
    std::ofstream outFile("console_out.ext", std::ios::trunc);

    if (!inFile || !outFile)
    {
        if (!inFile)
            std::cerr << "inFile descriptor initialization failed." << std::endl;
        else
            std::cerr << "outFile File descriptor initialization failed. " << std::endl;
        return EXIT_FAILURE;
    }
    

    while (!inFile.eof())
    {
        // Load the next item
        //charBuffer = inFile.get(); // Warning!!! This will not get the last 'w' will not recognize the last '+' character
        inFile.get(charBuffer);      // THis method will parse the text file properly!

        if (charBuffer == 0x7F)
        {
            // Get the proceding character
            charBuffer = inFile.get();
            // Get the next numerical value character
            num_reps = inFile.get();

            if (charBuffer == 0x7a)
            {
                num_reps = 10;
            }

            // Validate check to see if buffer is displayable character
            for (unsigned short i = 0; i < static_cast<unsigned short>(num_reps); i++)
            {
                // Print out to terminal and output file 
                std::cout << charBuffer;
                outFile << charBuffer;
            }

            // Flush write buffers
            std::cout << std::flush;
            outFile << std::flush;
        }
      
        else if (charBuffer != EOF)
        {
            outFile << charBuffer << std::flush;
            std::cout << charBuffer << std::flush;
        }
    } 

    // Close the filestream
    inFile.close();
    outFile.close();

    return EXIT_SUCCESS;
}

