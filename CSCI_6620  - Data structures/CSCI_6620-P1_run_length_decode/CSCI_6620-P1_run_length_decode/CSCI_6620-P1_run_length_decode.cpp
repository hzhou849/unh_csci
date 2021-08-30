// CSCI_6620-P1_run_length_decode.cpp : This file contains the 'main' function. Program execution begins and ends there.
// 
//HOWARD ZHOU 

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>


int logOutput(std::string &outputBuffer,  std::ofstream &outFile)
{
    std::cerr << outputBuffer << std::endl;
    outFile << outputBuffer;

    return EXIT_SUCCESS;
}

int main()
{
    int myVar = 128;
    
    unsigned int myVar2 = 56;
    char nextChar = 0;
    std::string outputBuffer = "";
   

    std::cout << "Hello World!\n";
    std::cout << std::hex << std::showbase << myVar << std::endl;
    std::cout << std::resetiosflags(std::ios::basefield);
    std::cout << myVar2 << std::endl;

    // Load the input file
    std::ifstream inFile("compressed1.txt", std::ios::in );
    std::ofstream outFile("console_out.ext", std::ios::trunc);


    if (!inFile || !outFile)
    {
        outputBuffer = "Error handling stream file";
        std::cerr << outputBuffer << std::endl;
        return EXIT_FAILURE;
    }
    else 
    {
        std::cerr << "Input text file loaded successfully!" << std::endl;

        while (!inFile.eof())
        {
            nextChar = inFile.get();
            if (nextChar == EOF)
            {
                std::cout << outputBuffer << std::endl;
                outFile << outputBuffer;
                break;
            }
            if (nextChar < 0x41 || nextChar > 0x7A)
            {
                std::cout << std::dec << "NUmber detected: " << static_cast<std::int32_t>(nextChar) << std::endl;
            }
            else
            {
                std::cout <<std::hex << std::showbase <<  "Character read: " << nextChar << std::endl;
            }
            
        
        } 
    }




    // Close the filestream
    inFile.close();
    outFile.close();

    return EXIT_SUCCESS;


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
