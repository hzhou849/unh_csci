//----------------------------------------------------------------------------- 
// File:        state.h
// 
// Project:     P1 - Square State
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-06-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"

// Constants
static const short BIT_MASK   = 0x0001;       // Mask used for extracting last bit
static const short ASCII_DASH = 0x2D;         // ASCII rep for '-'

//-----------------------------------------------------------------------------
// State Class
class State  {
private: 
    short posList=0;
    char  value=' ';
    bool  fixed = true;

public:  
    State ()=default;            
    State (char charIn);  
    ~State ()=default;           
    void mark (char ch);
    char getValue();
    ostream& printFull (ostream& os);
    ostream& print (ostream& os);
};

inline ostream& operator<< ( ostream& os, State& state ) {
    return state.print(os);
}

//=============================================================================
// Square Class
//=============================================================================
class Square {
private: 
    State stateObj;
    short sqRow;
    short sqCol;
    // std::vector<short> nbrSquare;  // as per instructions, used later

public:
    Square ()=default;
    Square (char charIn, short row, short col);
    ~Square();
    // char getStateVal();

    ostream& print (ostream& os);
    void mark();
};

inline ostream& operator << (ostream& os, Square& sqr) {
    return sqr.print(os);
}