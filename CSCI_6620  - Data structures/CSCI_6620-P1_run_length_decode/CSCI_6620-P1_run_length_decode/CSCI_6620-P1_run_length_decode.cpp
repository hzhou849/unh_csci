// CSCI_6620-P1_run_length_decode.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <fstream>


int main()
{
    int myVar = 128;
    
    unsigned int myVar2 = 56;
    char myChar;


    std::cout << "Hello World!\n";
    std::cout << std::hex << std::showbase << myVar << std::endl;
    std::cout << std::resetiosflags(std::ios::basefield);
    std::cout << myVar2 << std::endl;

    std::fstream in_file{ "compressed1.txt", std::ios::in };

    if (!in_file)
    {
        std::cerr << "Error loading input file" << std::endl;
        return EXIT_FAILURE;
    }
    else 
    {
        std::cerr << "Input text file loaded successfully!" << std::endl;

        
        while (!in_file.eof())
        {
            myChar = in_file.get();
            if (myChar < 0x41 || myChar > 0x7B)
            {
                std::cout << std::dec << "NUmber detected: " << static_cast<std::uint32_t>(myChar) << std::endl;
            }
            else
            {
                std::cout <<std::hex << std::showbase <<  "Character read: " << myChar << std::endl;
            }
        }
        
    }




    // Close the filestream
    in_file.close();

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
