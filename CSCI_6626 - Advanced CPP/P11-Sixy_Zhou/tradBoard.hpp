//----------------------------------------------------------------------------- 
// File:         tradBoard.hpp
// 
// Brief:        Traditional Board class derived from Board 
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#pragma once
#include "board.hpp"

class TradBoard : public Board {
private:
    virtual void crtBox(int box, Square* tempArr[]) ;
public:
    TradBoard (char type, ifstream& puzFile);
    virtual ~TradBoard() {};
    // virtual void extPrint() override;   // Debug testing function
};