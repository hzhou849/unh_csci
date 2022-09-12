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

class State  {
private: // -------------------------------------------------------------------
    short posList=0;
    char  value='-';
    bool  fixed = true;


public:  // -------------------------------------------------------------------
    State ()=default;            
    State (char param); 
    void mark (char ch);

    ~State ()=default;   

    ostream& print (ostream & os);
};

inline ostream& operator<< ( ostream& os, State& state ) {
    return state.print(os);
}