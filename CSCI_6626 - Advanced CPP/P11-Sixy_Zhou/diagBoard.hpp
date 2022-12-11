//----------------------------------------------------------------------------- 
// File:         diagBoard.hpp
// 
// Brief:        Diagonal Board class derived from Board header
//               with extra diagonal cluster fucntions
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tradBoard.hpp"

class DiagBoard : public TradBoard {
private:
    void crtUpLeftDiag( Square* tempArr[] );
    void crtUpRightDiag( Square* tempArr[] );

public:
    DiagBoard( char type, ifstream& puzFile);
    virtual ~DiagBoard() {};
    virtual void extPrint() override;   // Debug testing function
};

