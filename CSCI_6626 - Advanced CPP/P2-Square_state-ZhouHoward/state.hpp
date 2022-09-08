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
    short possibilities;
    char  value;
    bool  fixed = true;

public:  
    State ();            
    State (char charIn);  
    void mark (char ch);
    ~State();           
    char getValue();
    ostream& print (ostream & os);
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
    std::vector<short> nbrSquare;

public:
    Square ();
    Square (char charIn, short row, short col);
    ~Square();

    ostream& print ();
    void mark();
};

inline ostream& operator << (ostream& os, Square& sqr) {
    return sqr.print();
}