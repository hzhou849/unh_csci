//----------------------------------------------------------------------------- 
// File:        board.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project:     P4 - Board
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-27-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#include "board.hpp"

/// @brief Constructor
//-----------------------------------------------------------------------------
Board :: 
Board(int nSize, ifstream& puzFile) : nSize_m(nSize), inFile_m(puzFile) {
    bd_m = new Square[nSize_m * nSize_m]; 
    getPuzzle();
}


// a private helper function called from the constructor. 
// The ifstream will contain N lines of input. Each line consists of N data 
// characters and a newline. 
// A data character is a dash or a digit between 1 and N. 
// This function will read and process the N lines, and create N2 squares. 
// See detailed description in the next section.
void Board :: 
getPuzzle() {
    int row = 0;
    char tempChar;
    cout << "Constructing Board..." << endl;

    for (int iter=0; iter <= 100; iter++) {
        tempChar = inFile_m.get();
            cout << "readstate: [" << inFile_m.rdstate() << "], "
            << "good: [" << inFile_m.good() << "], "
            << "eof: [" << inFile_m.eof() << "], "
            << "bad: [" << inFile_m.bad() << "], ";

        if ( inFile_m.good() ) {
            if (tempChar == '\n')  {
                ++row;
                cout << "\n"  << "row: " << row;

            }
            else cout << "char: [" << tempChar << "]: " << "good!";
        }
        else if ( inFile_m.eof() ) break;
        else if ( inFile_m.fail() ) {
            inFile_m.clear();            // Clear bad characters out of the stream
            inFile_m.ignore(1);
        }
        else if ( inFile_m.bad() ) {     // Abort after an unrecoverable stream error
            fatal ("[!] Low-level error while reading input stream.");
        }
        cout << endl;
    }
    
}   

/// @brief Calculates 2D array coordinates
///
/// @return returns reference to Square object in the Board's array
Square& Board ::
sub( int row, int col ) {
    
}

