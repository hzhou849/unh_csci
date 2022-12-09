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

    // for (int box = 0; box < nSize_m; ++box) { crtHbox(tempArr) };
    for (int box = 0; box < nSize_m; ++box) { crtVbox(tempArr) };

    // Base class will prints first 3 constraint clusters, we will add 4th
    cout << "EXTENDED - SixyBoard() constructor w/Staggered cluster:" << endl;
    for ( size_t itr=27; itr<clus_m.size(); ++itr ) {
        cout << *clus_m.at(itr) << endl;
    }
}

// Modify this to do vertical boxes same function but change parameters
//-----------------------------------------------------------------------------
/// @brief create cluster of horiozntal boxes [3x2] 
/// @param[in] tempArr - buffer comprised of sq addresses for this cluster
//-----------------------------------------------------------------------------
void SixyBoard::hBox( int curBox, Square* tempArr[] ){
    int sqCell;
    int startSq;
    int count =0;
    int rowPerBox = 2, numBoxRows = 2;
    int sqBdRow = 12;           // Total number of sq in a full bd row. 
    int boxColPos = curBox % 2; // This box's column pos on bd's current row
                                // (Left or right) 0-indexed


    // Replace these vars with Height and length instead to make 
    // it easier to understand.


    startSq = (floor(curBox / numBoxRows) * sqBdRow )
    for (int outItr=0; outItr < 2; ++outItr) {

    }
} 
