//----------------------------------------------------------------------------- 
// File:         frame.hpp
// 
// Brief:        Frame object to store all the states of the square each turn
// 
// Project/ver:  P10 - Restore
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#pragma once
#include "tools.hpp"
#include "state.hpp"

class Frame {
private:
    int nSize;

public:
    State *arrState;
    Frame(int size): nSize(size) { arrState = new State[nSize*nSize]; }
    virtual ~Frame() { 
        delete[] arrState; cout << "[*] Deallocating Frame object" << endl; 
    }
    
    void serialize(ofstream& gameOut);
    void realize();
    ostream& print (ostream& os);
};

inline ostream& operator << (ostream& os, Frame& fObj) { 
    return fObj.print(os);
}

