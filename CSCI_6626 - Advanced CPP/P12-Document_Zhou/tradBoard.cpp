//----------------------------------------------------------------------------- 
// File:         tradBoard.hpp
// 
// Brief:        Derived from board, extra fuction for creating box clusters
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#include "tradBoard.hpp"

//-----------------------------------------------------------------------------
/// @brief Constructor - Delegates base class for base features 
/// @param[in] type    - Board type (d)diag, 
/// @param[in] puzFile - input file containing board_type and sq values.
//-----------------------------------------------------------------------------
TradBoard :: TradBoard (char type, ifstream& puzFile) : Board(type, puzFile) {
   cout << "***TradBoard this->nSize_m: " << nSize_m << endl;
    Square* tempArr[nSize_m];
    for (int box = 0; box < nSize_m; ++box) crtBox(box, tempArr);

    cout << "======= Traditional Clusters: ========" << endl;
    for (Cluster* a : clus_m) { cout << *a << endl; }
}


//-----------------------------------------------------------------------------
/// @brief Calculate all the N BOX sq and push box clusters into vector clus_m
///        For sixy, this function calculates the Horizontal boxes
/// @param[in] curBox - Current Box counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the col's N square*
//-----------------------------------------------------------------------------
void TradBoard ::
crtBox(int curBox, Square* tempArr[]) {

    int count=0;
    int startSq; int sqCell;
    // #rows of each sq per line in a box & columns of Boxes on board (9)=3; (6)=2 
    int rowPerBox = nSize_m / 3, boxCol = rowPerBox;   
    int sqBdRow;            // Total number sq in a full box row. (9)27 or (6)12
    int boxColPos;          // This Box's column position on board's current row
                            // for board size 9 (left, mid, right) = 3
                            // for board size 6 (left, right) = 2
    // Create 9 boxes

    if (nSize_m == 9) { sqBdRow = 27; boxColPos = curBox % 3; }
    else { sqBdRow = 12; boxColPos=curBox % 2; }

    startSq = (floor(curBox / boxCol) * sqBdRow) + (boxColPos * 3);

    // Cycle 3 times for 3 rows each square within a box
    for (int outItr = 0; outItr < rowPerBox; ++outItr) {
        for (int iter = 0; iter < 3; ++iter) {  
            sqCell = (outItr * nSize_m) + startSq + iter;
            tempArr[count++] = &arrSqs_m[sqCell];
        }
    }
    clus_m.push_back(new Cluster( nSize_m, ClusterT::BOX, tempArr ) );

}