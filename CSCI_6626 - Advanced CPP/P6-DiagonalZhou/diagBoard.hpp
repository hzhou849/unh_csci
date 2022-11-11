//----------------------------------------------------------------------------- 
// File:         diagBoard.hpp
// 
// Brief:        Diagonal Board class derived from Board
// 
// Project/ver:  P6 - Diagonal
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "board.hpp"

class DiagBoard : public Board {

private:
    void crtUpLeftDiag(Square* tempArr[]);
    void crtUpRightDiag(Square* tempArr[]);

public:
    DiagBoard( char type, ifstream& puzFile);
    virtual ~DiagBoard() {};
    virtual void extPrint() override;   // Debug testing function

};

