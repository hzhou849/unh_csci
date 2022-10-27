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

//-----------------------------------------------------------------------------
/// @brief Constructor Cluster- Creates cluster type and binds this to its Sqs.
///        Call Square* to add this instance of cluster to this square's vector
///        Producing 2-way access to get from a cluster to sq and vice-versa.
///        Each square hold its own record of Cluster of row, col & Box 
/// @param[in] cType  - an enum type used label this cluster
/// @param[in] argPtr - Array to hold this cluster's N #of values
//-----------------------------------------------------------------------------
Cluster ::Cluster(ClusterT cType, Square *argPtr[])
    : cType_m(clist[static_cast<int>(cType)])       {               // As per instructions to take in ClusterT to char*
    arrPt_m = new Square[nSize_m];

    for (int it = 0; it < nSize_m; it++) {
        arrPt_m[it] = *argPtr[it];
        argPtr[it]->addCluster(this);
        // cout << cType_m<<": "<< i << ") " << *arrPtr[i]  << endl;
    }
}

//-----------------------------------------------------------------------------
/// @brief Eliminates values from the possibilities list
/// @param[in] val - character to remove from the list
//-----------------------------------------------------------------------------
void Cluster ::
shoop(char val) {
    int num = (val - '0'); // Char subtraction to convert value
    cout << "num: " << num;

    // - for each of the nine sq* in this cluster, to turn off the num bit
    for (int it=0; it < nSize_m; ++it)  arrPt_m[it].turnOff(num);

//each cluster calls Square::shoop() -> cluster::shoop(val) -> square*::turnOff(num)
    //call from main
}

//-----------------------------------------------------------------------------
/// @brief iterates through member array[N] squares for this cluster instance
//-----------------------------------------------------------------------------
ostream &Cluster ::
print(ostream &os) {
    os << "CType: " <<  cType_m << "\n";
    for (int it = 0; it < nSize_m; ++it){ os << arrPt_m[it] << endl; }
    return os;
}
