//----------------------------------------------------------------------------- 
// File:         diagBoard.hpp
// 
// Brief:        Derived from board, extra functions to create diag clusters
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#include "diagBoard.hpp"

//-----------------------------------------------------------------------------
/// @brief Constructor. Diagonal Board derived from Board() to hold two
///                      additional diagonal clusters           
/// @param[in] type    - Board type (d)diag, 
/// @param[in] puzFile - input file containing board_type and sq values.
//-----------------------------------------------------------------------------
DiagBoard::DiagBoard( char type, ifstream& puzFile) : TradBoard(type, puzFile) {
    Square *tempArr[9]; 
    crtUpLeftDiag(tempArr);
    crtUpRightDiag(tempArr);

    // Print out all clusters here
    cout << "======= diagBoard Clusters: ========" << endl;
    for (Cluster* a : clus_m) { cout << *a << endl; }
}


//-----------------------------------------------------------------------------
/// @brief Create diagonal cluster form UPPER-LEFT to LOWER-RIGHT corners
/// @param tempArr - buffer to store square addr for this cluster
//-----------------------------------------------------------------------------
void DiagBoard :: 
crtUpLeftDiag ( Square* tempArr[] ) {
    int sqCell;
    for (int itr=0; itr < nSize_m; ++itr) {
        sqCell = ( (itr * nSize_m) + itr );
        tempArr[itr] = &arrSqs_m[sqCell];
    }
    clus_m.push_back(new Cluster (nSize_m, ClusterT::DIAG, tempArr));
}


//-----------------------------------------------------------------------------
/// @brief Create diagonal cluster form UPPER-RIGHT to LOWER-LEFT corners
/// @param tempArr - buffer comprised of square addr for this cluster
//-----------------------------------------------------------------------------
void DiagBoard :: 
crtUpRightDiag ( Square* tempArr[] ) {
    int sqCell;
    for (int itr=0; itr <nSize_m; ++itr) {
        sqCell = ( (itr+1) * (nSize_m-1 ) );
        tempArr[itr] = &arrSqs_m[sqCell];
    }
    clus_m.push_back(new Cluster (nSize_m, ClusterT::DIAG, tempArr));
}

//*** For debugging, will remove later
void DiagBoard :: extPrint()  {
    cout << "Testing Diagonal cluster print" << endl;
    for (size_t itr=27; itr<Board::clus_m.size(); ++itr) {
        cout << *Board::clus_m.at(itr) <<"\n";
    }
}