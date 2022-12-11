//----------------------------------------------------------------------------- 
// File:         sixyBoard.hpp
// 
// Brief:        Sixy Board class derived from Board header
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#pragma once
#include "board.hpp"

class SixyBoard : public Board {
private:
    void crtHbox( int curBox, Square* tempArr[] );
    void crtVbox( int curBox, Square* tempArr[] );

public:
    SixyBoard ( char type, ifstream& puzFile );
    virtual ~SixyBoard() {};
    // virtual void extPrint() override;
};