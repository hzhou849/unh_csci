// CSCI_6620 - Data Structure
// Professor Thomas Shokite
// 
// CSCI_6620-P1_run_length_decode.cpp - Assignment 1
// 
// HOWARD ZHOU  - ID# 00748064

#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <sstream>


// Helper function to display the output and write to output file
int logOutput(std::ostringstream &outputBuffer,  std::ofstream &outFile)
{
    std::cerr << outputBuffer.str() << std::flush;
    outFile << outputBuffer.str() << std::flush;

    outputBuffer.str(""); // Clear the stream buffer
    outputBuffer.clear(); // Clear the stream errorbits

    return EXIT_SUCCESS;
}

int main()
{
    char charBuffer = 0;
    char my_character = 0;
    unsigned short int num_reps = 0;
    std::ostringstream ssOutputBuffer{};

    
    // Load the input file
    std::ifstream inFile("compressed1.txt", std::ios::in );
    std::ofstream outFile("console_out.ext", std::ios::trunc);

    if (!inFile || !outFile)
    {
        if (!inFile)
            ssOutputBuffer << "inFile descriptor initialization failed." << std::endl;
        else
            ssOutputBuffer << "outFile File descriptor initialization failed. " << std::endl;
        logOutput(ssOutputBuffer, outFile);

        return EXIT_FAILURE;
    }
    else 
    {
        while (!inFile.eof())
        {   
            // Load the next item
            charBuffer = inFile.get();
            
            
            if (charBuffer == 0x7F)
            {
                // Get the proceding character
                charBuffer = inFile.get();
                // Get the next numerical value character
                num_reps = static_cast<unsigned short>(inFile.get());

               // Validate check to see if buffer is displayable character
                //if ( (charBuffer > 0x1F) && (charBuffer < 0x7B) )
                for (unsigned short int i=0; i < num_reps; i++)
                {
                    // Assign the current buffer value to current placeholder variable
                    my_character = charBuffer;

                    //std::cout <<"\n"<< i << ": [" << charBuffer << "]" << std::endl;
                    ssOutputBuffer << charBuffer;
                }
                ssOutputBuffer << std::flush;
                logOutput(ssOutputBuffer, outFile);

            }
            else if (charBuffer != EOF)
            {
                //std::cout << "\n" << ": [" << charBuffer << "]" << std::endl;
                ssOutputBuffer << charBuffer << std::flush;
                logOutput(ssOutputBuffer, outFile);
            }
        } 
    }

    // Close the filestream
    inFile.close();
    outFile.close();

    return EXIT_SUCCESS;
}

