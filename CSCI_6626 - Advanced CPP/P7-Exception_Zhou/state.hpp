//----------------------------------------------------------------------------- 
// File:        state.hpp
// 
// Brief:       Manages the state of the square
//
// Project/ver:  P7 - Exception
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"

// Constants
static const short BIT_MASK   = 0x0001;       // Mask used for extracting last bit

class State  {
protected: 
    short posList=0;
    char  value=' ';
    bool  fixed = true;

public:  
    State ()=default;            
    State (char charIn);  
    ~State ()=default;           
    void mark (char ch);
    char getValue();
    void adjPlist(int val);
    ostream& printFull (ostream& os);
    ostream& print (ostream& os);
};

inline ostream& operator<< ( ostream& os, State& state ) {
    return state.print(os);
}

