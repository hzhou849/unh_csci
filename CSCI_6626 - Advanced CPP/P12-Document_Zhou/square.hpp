//----------------------------------------------------------------------------- 
// File:         square.hpp (Inherit from state)
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#pragma once
#include "state.hpp"

// Forward declaration
class Cluster;

class Square : public State {
protected: 
    State stateObj;
    short sqRow;
    short sqCol;
    vector <Cluster*> clues_m;

public:
    void sqShoop();
    Square ()=default;
    Square (char charIn, short row, short col);
    ~Square();
    inline void addCluster(Cluster* clus) { clues_m.push_back(clus); }
    ostream& print (ostream& os) const;
    bool mark(char newChar);
    void turnOff (int n);
    State getState() { return stateObj;}
    void setState(State st) {stateObj = st;}
};

inline ostream& operator << (ostream& os, const Square& sqr) {
    return sqr.print(os);
}