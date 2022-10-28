//=============================================================================
// Square Class - Derived from State
//=============================================================================
#pragma once
#include "state.hpp"

// Forward declaration
class Cluster;

class Square : public State {
private: 
    State stateObj;
    short sqRow;
    short sqCol;
    // std::vector<Square*> nbrSquare;  // as per instructions, used later
    std::vector<Cluster*> clues_m;


public:
    void shoop();
    Square ()=default;
    Square (char charIn, short row, short col);
    ~Square();

    inline void addCluster(Cluster* clus) { clues_m.push_back(clus); }

    ostream& print (ostream& os);
    stringstream prState();
    void mark(char newChar);
    void turnOff (int n);
};

inline ostream& operator << (ostream& os, Square& sqr) {
    return sqr.print(os);
}