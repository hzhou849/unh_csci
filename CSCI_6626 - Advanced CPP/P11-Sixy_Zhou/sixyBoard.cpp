//----------------------------------------------------------------------------- 
// File:         sixyBoard.hpp
// 
// Brief:        sixy Board class derived from Board implementation
// 
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#include "sixyBoard.hpp"

//-----------------------------------------------------------------------------
/// @brief Constructor derived from Board() to hold extra staggered cluster
/// @param[in] type - Board type (s)ixy
/// @param[in] puzFile - input file containing board_type and sq values.
//-----------------------------------------------------------------------------
SixyBoard::SixyBoard( char type, ifstream& puzFile ) : Board(type, puzFile) {
    Square *tempArr[6];
    cout << "EXTENDED - SixyBoard() constructor w/Staggered cluster:" << nSize_m << endl;

    for (int boxNm = 0; boxNm < nSize_m; ++boxNm) { crtHbox(boxNm, tempArr); }
    for (int boxNm = 0; boxNm < nSize_m; ++boxNm) { crtVbox(boxNm, tempArr); }

    cout << "======= Sixy Clusters: ========" << endl;
    for (Cluster* a : clus_m) { cout << *a << endl; }
}


//-----------------------------------------------------------------------------
/// @brief create cluster of HORIZONTAL boxes [x2] 
/// @param[in] tempArr - buffer comprised of sq addresses for this cluster
//-----------------------------------------------------------------------------
void SixyBoard::crtHbox( int curBox, Square* tempArr[] ){
     int count=0;
    int startSq; int sqCell;
    // #rows of each sq per line in a box & columns of Boxes on board (9)=3; (6)=2 
    int rowPerBox = nSize_m / 3, boxCol = rowPerBox;   
    int sqBdRow;            // Total number sq in a full box row. 2 x 6 = 18
    int boxColPos;          // This Box's column position on board's current row
                            // for board size 9 (left, mid, right) = 3
                            // for board size 6 (left, right) = 2

    if (nSize_m == 9) { sqBdRow = 27; boxColPos = curBox % 3; }
    else { sqBdRow = 12; boxColPos=curBox % 2; }

    startSq = (floor(curBox / boxCol) * sqBdRow) + (boxColPos * 3);

    // Cycle 3 times for 3 box columns per board 
    for (int outItr = 0; outItr < rowPerBox; ++outItr) {
        for (int iter = 0; iter < 3; ++iter) {  
            sqCell = (outItr * nSize_m) + startSq + iter;
            tempArr[count++] = &arrSqs_m[sqCell];
        }
    }
    clus_m.push_back(new Cluster( nSize_m, ClusterT::BOX, tempArr ) );
    
} 

//-----------------------------------------------------------------------------
/// @brief create cluster of VERTICAL boxes [2x3] 
/// @param[in] tempArr - buffer comprised of sq addresses for this cluster
//-----------------------------------------------------------------------------
void SixyBoard::crtVbox( int curBox, Square* tempArr[] ){
     int count=0;
    int startSq; int sqCell;
    // #rows of each sq per line in a box & columns of Boxes on board (9)=3; (6)=2 
    int rowPerBox =3, boxCol = 3;   
    int sqBdRow = 18;            // Total number sq in a full box row. 3 x 6 = 18
    int boxColPos = curBox % 3;  // This Box's column position on board's 
                                 // current row
                                 // Vertical Box(left, mid, right) = 3


    startSq = (floor(curBox / boxCol) * sqBdRow) + (boxColPos * 2); //2 sq/rrow

        // in Cycle 3 rows per box for times for 2 box columns per board 
    for (int outItr = 0; outItr < rowPerBox; ++outItr) {
        for (int iter = 0; iter < 2; ++iter) {  
            sqCell = (outItr * nSize_m) + startSq + iter;
            tempArr[count++] = &arrSqs_m[sqCell];
        }
    }
    clus_m.push_back(new Cluster( nSize_m, ClusterT::VBOX, tempArr ) );
    
} 
