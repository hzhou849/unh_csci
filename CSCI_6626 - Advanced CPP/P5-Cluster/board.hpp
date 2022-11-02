//----------------------------------------------------------------------------- 
// File:         board.hpp
// 
// Brief:        A basic controller class for the applicaiton
// 
// Project/ver:  P5 - Cluster
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"
#include "square.hpp"
#include "cluster.hpp"

// For extern use:
 // Not sure how you want us to share this with cluster??
// static const char* clist[3] = {"Row", "column", "Box"};  // Not sure how you want us to share this with cluster??

class Board {
private:
    // Member variables
    int         nSize_m; 
    short int   left_m;
    Square*     bd_m;
    ifstream&   inFile_m;
    vector<Cluster*> clus_m;

    // Member functions
    void getPuzzle();
    Square& sub( int row, int col );
    void mkCluster();
    void crtColumn(int curCol, Square* tempArr[]);
    void crtBox(int curBox, Square *tempArr[]);
    void crtRow(int curRow, Square* tempArr[]);

public: 
    Board( char type, ifstream& puzFile );
    ~Board() { delete []bd_m; cout << "[*] Deallocating board object" << endl; }
    void testShoop();
    ostream& print( ostream& os );
};

inline ostream& operator<< (ostream& os, Board& boardObj) {
    return boardObj.print(os);
}