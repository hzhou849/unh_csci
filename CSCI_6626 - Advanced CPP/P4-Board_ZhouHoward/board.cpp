//----------------------------------------------------------------------------- 
// File:        board.hpp
// 
// Brief:       Generate the board of squares
// 
// Project:     P4 - Board
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#include "board.hpp"

/// @brief Constructor
//-----------------------------------------------------------------------------
Board :: 
Board( char type, ifstream& puzFile ) : inFile_m(puzFile) {
    if ( type == 't' || type == 'd' ) { nSize_m = 9; }
    else if ( type == 's' ) { nSize_m = 6; }
    else { fatal( "[!]ERROR - invalid type entered: " + string(1,type) ); }
    
    bd_m = new Square[nSize_m * nSize_m]; 
    getPuzzle();
    cout << "Board constructor is done." << endl;
}


/// @brief Generates the board array and assigns the squares
void Board :: 
//-----------------------------------------------------------------------------
getPuzzle() {
    char tempChar;
    cout << "Constructing Board..." << endl;
    for (int rowIter=1; rowIter <= nSize_m; rowIter++) {

        for (int colIter=1; colIter <= nSize_m; colIter++) {
            inFile_m >> tempChar;
            if ( inFile_m.good() ) {
                if ( (tempChar >= '0' && tempChar <='9') || (tempChar == '-') ) {
                    cout << " [" << tempChar << "]: "  << "row: " << rowIter 
                         << " col: " << colIter;
                    sub(rowIter, colIter) = Square(tempChar,rowIter,colIter);
                }
                else if (tempChar == '\n')  {
                    cout << "\n"  << "row: " << rowIter;
                }
                else {
                    cout << tempChar;
                    fatal("[!] ERROR - invald character in file: " );
                }
            }
            else if ( inFile_m.eof() ) {
                cout << endl;
                break;
            }
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
}   


/// @brief Calculates 2D array coordinates
/// @param [in] row : postion in board
/// @param [in] col : position in board
/// @return &reference to Square object in the Board's array
//-----------------------------------------------------------------------------
Square& Board::
sub( int row, int col ) {
    return bd_m[ ( row -1 ) *9 + ( col-1 )];
}


/// @brief Print display the values for this object
/// @param [in] os : stream object to store data
/// @return stream output object
//-----------------------------------------------------------------------------
ostream& Board :: 
print(ostream& os) {
    for (int iter=0; iter < (nSize_m * nSize_m); iter++) {
        os << bd_m[iter];

        if (iter % nSize_m == 8) {
            os << "\n";
        }
    }
    return os;
}
