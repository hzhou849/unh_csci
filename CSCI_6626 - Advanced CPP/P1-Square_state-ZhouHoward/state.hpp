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

class State  {
private: // -------------------------------------------------------------------
    short possibilities;
    char  value;
    bool  fixed;





public:  // -------------------------------------------------------------------
    State();            // Default Constructor
    State(char param);  // Overloaded Constructor

    ~State();           // Destructor

    void mark(char ch);
    ostream& print(ostream & os);


};

inline std::ostream& operator<<(std::ostream& os, State& state) {
    return state.print(os);
}