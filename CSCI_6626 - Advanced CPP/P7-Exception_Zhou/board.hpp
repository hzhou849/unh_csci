//----------------------------------------------------------------------------- 
// File:         board.hpp
// 
// Brief:        A basic controller class for the applicaiton
// 
// Project/ver:  P7 - Exception
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"
#include "square.hpp"
#include "cluster.hpp"

class Board {
protected:
    // Member variables
    int         nSize_m;
    short int   left_m;
    Square*     arrSqs_m;
    ifstream&   inFile_m;
    vector <Cluster*> clus_m;

    // Member functions
    void getPuzzle();
    Square& sub( int row, int col );
    void mkCluster();
    void crtColumn(int curCol, Square* tempArr[]);
    void crtBox(int curBox, Square* tempArr[]);
    void crtRow(int curRow, Square* tempArr[]);

public: 
    Board( char type, ifstream& puzFile );
    virtual ~Board() { delete []arrSqs_m; cout << "[*] Deallocating board object" << endl; }
    void bdShoop();
    ostream& print( ostream& os ) const;
    virtual void extPrint() {}
    void mark(char row, char col, char value);
};


inline ostream& operator<< (ostream& os, const Board& boardObj) {
    return boardObj.print(os);
}