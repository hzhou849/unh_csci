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
static const char* clist[3] = {"Row", "column", "Box"};
class Cluster {
private:
    static const int nSize_m;           // to allow simple board size change in future
    // Member variables
    const char* cType_m;
    Square*     arrPt_m;  // An array of 9 Square pointers
    // static const char* list_m[3];
    // static const string list_m[3];
    void shoop( char val );

public:
    // static constexpr char* clist[3] = {"Row", "Column", "Box"};

    // Dr Fischer, is there a reason why you want it done this way?
    Cluster()=default;
    Cluster(ClusterT cType, Square* arrPtr[] );
    Cluster(string cType, Square* arrPtr[] );
    ~Cluster() { delete[] arrPt_m;}

    ostream& print(ostream& os) ; // delegate to Square::print();

};

inline ostream& operator<< (ostream& os,  Cluster cObj) {
    return cObj.print(os);
}

// // ****Implementation *****
// Cluster::Cluster( ClusterT cType, Square* arrPtr[]) 
//     : cType_m(clist[static_cast<int>(cType)]) {
//     // As per instructions to take in ClusterT to char*

        
//         arrPt_m = new Square[9];

//         for (int i=0; i < 9; i++) {
//             cout << cType_m<<": "<< i << ") " << *arrPtr[i]  << endl;
//         }


// }



// Cluster::Cluster( ClusterT cType, Square* arrPtr[]) 
//     : cType_m(clist[static_cast<int>(cType)])           // As per instructions to take in ClusterT to char*
//     {

        
//         arrPt_m = new Square[9];

//         for (int i=0; i < 9; i++) {
//             cout << cType_m<<": "<< i << ") " << *arrPtr[i]  << endl;
//         }


// }
