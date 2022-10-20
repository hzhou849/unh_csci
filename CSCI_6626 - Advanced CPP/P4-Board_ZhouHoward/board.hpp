//----------------------------------------------------------------------------- 
// File:        board.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project:     P4 - Board
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"
#include "state.hpp" // Square class is in here

class Board {
private:
    // Member variables
    int         nSize_m; 
    short int   left_m;
    Square*     bd_m;
    ifstream&   inFile_m;
    
    // Member functions
    void getPuzzle();
    Square& sub( int row, int col );

public: 
    Board( char type, ifstream& puzFile );
    ~Board() { delete []bd_m; cout << "[*] Deallocating board object" << endl; }
    ostream& print( ostream& os );
};

inline ostream& operator<< (ostream& os, Board& boardObj) {
    return boardObj.print(os);
}