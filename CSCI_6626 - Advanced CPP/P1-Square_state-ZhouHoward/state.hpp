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

class State  {
private: // -------------------------------------------------------------------
    short possibilities;
    char  value;
    bool  fixed;

public:  // -------------------------------------------------------------------
    State ();            // Default Constructor
    State (char param);  // Overloaded Constructor
    void mark (char ch);

    ~State();           // Destructor

    ostream& print (ostream & os);
};

inline ostream& operator<< ( ostream& os, State& state ) {
    return state.print(os);
}