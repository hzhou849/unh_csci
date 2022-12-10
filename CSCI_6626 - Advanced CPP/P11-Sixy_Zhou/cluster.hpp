//----------------------------------------------------------------------------- 
// File:        cluster.hpp
// 
// Brief:       Cluster is used by board. Each board contains 3 * N clusters
// 
// Project/ver:  P11 - Sixy
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "square.hpp"   // Cluster will contain an array of square pointers
#include "board.hpp"

enum class ClusterT {ROW, COLUMN, BOX, DIAG, SIXY};  // Will not be visible if placed in board.hpp

class Cluster {
private:
    static const char* clist[5];
    int nSize_m;        

    // Member variables 
    const char* cType_m;
    Square**    arrPt_m;               // An array of 9 Square pointers

public:
    void clShoop( char val );
    Cluster()=default;
    Cluster(ClusterT cType, Square* arrPtr[] );
    ~Cluster() { delete[] arrPt_m;}
    ostream& print(ostream& os) const ;
};

inline ostream& operator<< (ostream& os, const Cluster& cObj) {
    return cObj.print(os);
}