//----------------------------------------------------------------------------- 
// File:        game.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project:     P3 - Square
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-20-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#include "game.hpp"

/// @brief Constructor
/// @param [in] fileName - file to be read
Game :: Game ( string fileName ) {

    // Read input file
    inputFile_m.open(fileName, ios_base::in);

    if (!inputFile_m) {
        fatal("Fatal Error! - Game() failed to open file.");
    }

    cout << "file read successfully: " << endl;
    string text;
    char testChar;

    // Or are we using >>? 
    inputFile_m>>std::ws;       // skip all whitespaces for this ifstream object
    inputFile_m.get(testChar) ; 

    std::cout << "test read: " << testChar << endl;
    inputFile_m >> testChar;
    std::cout << "test read2: " << testChar << endl;


    // Check for eof()
    inputFile_m.close();
    
}



