//----------------------------------------------------------------------------- 
// File:         board.hpp
// 
// Brief:        A basic controller class for the applicaiton
// 
// Project/ver:  P10 - Restore
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
// valgrind --leak-check=full ./main puzt.txt 
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"
#include "square.hpp"
#include "cluster.hpp"
#include "myExcept.hpp"
#include "CanView/CanView.hpp"
#include "stack.hpp"

class Board : public CanView {
protected:
    // Member variables
    int         nSize_m;
    int         bdSize_m = nSize_m*nSize_m;
    short int   left_m;
    Square*     arrSqs_m;
    ifstream&   inFile_m;
    vector <Cluster*> clus_m;
    Stack<Frame*> stackUndo_m;
    Stack<Frame*> stackRedo_m;

    // Member functions
    void getPuzzle();
    Square& sub( int row, int col );
    void mkCluster();
    void crtColumn(int curCol, Square* tempArr[]);
    void crtBox(int curBox, Square* tempArr[]);
    void crtRow(int curRow, Square* tempArr[]);
    void printStack();
    void bkState();

public: 
    Board( char type, ifstream& puzFile );
    virtual ~Board();

    virtual char getMarkChar(int row, int col) const;
    virtual string getPossibilityString(int row, int col) const;
    void bdShoop();
    ostream& print( ostream& os ) const;
    virtual void extPrint() {}
    void mark(char row, char col, char value);
    void undo();
    void redo();
    void restoreState( Frame* );
    void saveBd();
    void restoreBd();
};


inline ostream& operator<< (ostream& os, const Board& boardObj) {
    return boardObj.print(os);
}