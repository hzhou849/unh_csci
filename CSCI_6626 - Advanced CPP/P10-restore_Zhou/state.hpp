//----------------------------------------------------------------------------- 
// File:        state.hpp
// 
// Brief:       Manages the state of the square
//
// Project/ver:  P10 - Restore
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"
#include "myExcept.hpp"

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
    bool getFixed() {return fixed; }
    void adjPlist(int val);
    ostream& printFull (ostream& os);
    ostream& print (ostream& os);
};

inline ostream& operator<< ( ostream& os, State& state ) {
    return state.print(os);
}

