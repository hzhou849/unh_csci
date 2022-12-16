//----------------------------------------------------------------------------- 
// File:        cluster.hpp
// 
// Brief:       Cluster is used by board. Each board contains 3 * N clusters
// 
// Project/ver: P5 - Cluster
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "square.hpp"   // Cluster will contain an array of square pointers
#include "board.hpp"

enum class ClusterT {ROW, COLUMN, BOX};  // Will not be visible if placed in board.hpp

class Cluster {
private:
    static const char* clist[3];
    static const int nSize_m;        

    // Member variables 
    const char* cType_m;
    Square**    arrPt_m;               // An array of 9 Square pointers

public:
    void shoop( char val );
    // static constexpr char* clist[3] = {"Row", "Column", "Box"};

    Cluster()=default;
    Cluster(ClusterT cType, Square* arrPtr[] );
    ~Cluster() { delete[] arrPt_m;}
    ostream& print(ostream& os) ;
};

inline ostream& operator<< (ostream& os,  Cluster& cObj) {
    return cObj.print(os);
}