//----------------------------------------------------------------------------- 
// File:         square.hpp (Inherit from state)
// 
// Project/ver:  P6 - Diagonal
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#pragma once
#include "state.hpp"

// Forward declaration
class Cluster;

class Square : public State {
private: 
    State stateObj;
    short sqRow;
    short sqCol;
    std::vector<Cluster*> clues_m;

public:
    void sqShoop();
    Square ()=default;
    Square (char charIn, short row, short col);
    ~Square();
    inline void addCluster(Cluster* clus) { clues_m.push_back(clus); }
    ostream& print (ostream& os);
    void mark(char newChar);
    void turnOff (int n);
};

inline ostream& operator << (ostream& os, Square& sqr) {
    return sqr.print(os);
}