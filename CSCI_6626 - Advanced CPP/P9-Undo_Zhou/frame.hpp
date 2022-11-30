//----------------------------------------------------------------------------- 
// File:         frame.hpp
// 
// Brief:        Frame object to store all the states of the square each turn
// 
// Project/ver:  P9 - Undo
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
        delete[] arrState; 

      

        cout << "[*] Deallocating Frame object" << endl; }

    ostream& print (ostream& os) { 
        int bSize = nSize * nSize;
        for (int itr=0; itr < bSize; ++itr) {
            if (itr % nSize == 0) {
                os << "\n";
            }
            
            if (itr <= 9 ) { os << " (" << itr<<")"; }
            else  os <<"("<<itr<<")";
            os << arrState[itr] << " ";
            

        }
        os << "\n" << endl;
        return os;
    }
};

inline ostream& operator << (ostream& os, Frame& fObj) { 
    return fObj.print(os);
}