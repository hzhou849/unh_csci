//-----------------------------------------------------------------------------
// File:        cluster.cpp
//
// Brief:       Cluster a groups of N squares
//
// Project/ver: P5 - Cluster
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------
#include "cluster.hpp"

/* Static constants */
const int Cluster::nSize_m = 9;
const char* Cluster::clist[3] = {"Row", "column", "Box"};

//-----------------------------------------------------------------------------
/// @brief Constructor Cluster- Creates cluster type and binds this to its Sqs.
///        Call Square* to add this instance of cluster to this square's vector
///        Producing 2-way access to get from a cluster to sq and vice-versa.
///        Each square hold its own record of Cluster of row, col & Box 
/// @param[in] cType  - an enum type used label this cluster
/// @param[in] argPtr - Array to hold this cluster's N #of values
//-----------------------------------------------------------------------------
Cluster :: Cluster(ClusterT cType, Square* argPtr[])
    : cType_m( clist[static_cast<int>(cType)] ) {   // As per instructions to take in ClusterT to char*
    arrPt_m = new Square*[nSize_m];

    for (int it = 0; it < nSize_m; it++) {
        argPtr[it]->addCluster(this);
        arrPt_m[it] = argPtr[it];
    }
}

//-----------------------------------------------------------------------------
/// @brief Cycle this cluster and eliminate values from each Sq's pos. list
/// @param[in] val - character to remove from the list
//-----------------------------------------------------------------------------
void Cluster ::
shoop(char val) {
    int num = (val - '0');                  // Char subtraction to convert value
    if (num > 0 ) {                         // Skip the squares with '-'
        cout << "\n\nRemoving num: [ " << num << " ] from Cluster Type: [ "
             << cType_m << " ]"<< endl;
        for (int it=0; it < nSize_m; ++it)  arrPt_m[it]->turnOff(num);
    } 
}

//-----------------------------------------------------------------------------
/// @brief iterates through member array[N] squares for this cluster instance
/// @param[out] os - Stream to return back for terminal pr
//-----------------------------------------------------------------------------
ostream& Cluster ::
print(ostream &os) {
    os << "CType: " <<  cType_m << "\n";
    for (int it = 0; it < nSize_m; ++it) { os << *arrPt_m[it] <<endl; }
    return os;
}
