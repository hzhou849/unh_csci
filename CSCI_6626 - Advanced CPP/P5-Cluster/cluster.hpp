//----------------------------------------------------------------------------- 
// File:        cluster.hpp
// 
// Brief:       Cluster is used by board. Each board contains 3 * N clusters
// 
// Project:     P5 - Cluster
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#include "square.hpp"   // Cluster will contain an array of square pointers


    enum class ClusterT {ROW, COLUMN, BOX};

class Cluster {
private:
    // Member variables
    const char* cType_m;
    Square*     arr_m[9];  // An array of 9 Square pointers
// static constexpr string clusterStr[3] = {"Row", "Column", "Box"};

public:

    // Dr Fischer, is there a reason why you want it done this way?
    static constexpr char* list[3] = {"Row", "Coloum", "Box"};
    Cluster();
    Cluster(ClusterT cType, Square* arrPtr );

    ostream& print(ostream& os) const; // delegate to Square::print();

};

inline ostream& operator<< (ostream& os, const Cluster cObj) {
    return cObj.print(os);
}

// Implementation

Cluster::Cluster( ClusterT cType, Square* arrPtr) 
    : cType_m(list[static_cast<int>(cType)]), arr_m(arrPtr){};