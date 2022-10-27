//-----------------------------------------------------------------------------
// File:         board.hpp
//
// Brief:        Generate the board of squares
//
// Project/ver:  P5 - Cluster
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#include "board.hpp"
// #include "cluster.hpp"

// const char* Board::list_m[3] = {"Row", "column", "Box"};

//-----------------------------------------------------------------------------
/// @brief Constructor - Board handles creating 3* N clusters of N Sq* each
//-----------------------------------------------------------------------------
Board ::Board(char type, ifstream &puzFile) : inFile_m(puzFile) {
    if (type == 't' || type == 'd') { nSize_m = 9; }
    else { nSize_m = 6; }

    bd_m = new Square[nSize_m * nSize_m];
    getPuzzle();
    mkCluster();
}

//-----------------------------------------------------------------------------
/// @brief Helper function to kickoff creating all row,column and box clusters
//-----------------------------------------------------------------------------
void Board ::
mkCluster() {
    cout << "\n\n\n *******makeCluster called! *****************\n\n\n"<< endl;
    Square *tempArr[9]; // As per instructions re-use this local array for all 27 cluster
    
    /* Create Row/Column/Box clusters */
    for (int row=0; row < nSize_m; ++row) crtRow(row, tempArr); 
    for (int col=0; col < nSize_m; ++col) crtColumn(col, tempArr);
    for (int box=0; box < nSize_m; ++box) crtBox(box, tempArr);

    cout << "\n\nBoard() Printing cluster sets: \n";
    for (Cluster *c : clus_m) cout << *c << endl;
}


//-----------------------------------------------------------------------------
/// @brief Calculate all the N ROWS sqs and pushes row clusters into vector clus_m 
/// @param[in] curRow - Current Row counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the row's N square*  
//-----------------------------------------------------------------------------
void Board :: 
crtRow(int curRow, Square *tempArr[]) {
    int sqCell;
    for (int it = 0; it < nSize_m; ++it) {
        sqCell = ( (curRow * nSize_m) + it ); 
        tempArr[ it ] = &bd_m[ sqCell ];
        // cout << "bd_" << it << ") " << bd_m[sqCount] << endl;
    }
    clus_m.push_back( new Cluster(ClusterT::ROW, tempArr) );
}


//-----------------------------------------------------------------------------
/// @brief Calculate all the N COLUMNS sqs and push col clusters into vector clus_m 
/// @param[in] curCol - Current column counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the col's N square*  
//-----------------------------------------------------------------------------
void Board ::
crtColumn(int curCol, Square *tempArr[]) {
    int sqCell;
    for (int it = 0; it<nSize_m; ++it) {
        sqCell = (it * nSize_m) + curCol;      
        tempArr[it] = &bd_m[sqCell];
    }
    clus_m.push_back( new Cluster(ClusterT::COLUMN, tempArr) );
}


//-----------------------------------------------------------------------------
/// @brief Calculate all the N BOX sq and push box clusters into vector clus_m 
/// @param[in] curBox - Current Box counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the col's N square*  
//-----------------------------------------------------------------------------
void Board ::
crtBox(int curBox, Square *tempArr[]) {
  int sqCell;
  int offset = (nSize_m - 3) +1;
  for (int it=0; it<nSize_m; ++it) {
    sqCell = 0; // Start at Sq cell 0
  }
}
    int tally=0;
    for (i=0<3) {

        for (j=0<3)
        
        // 3 loops OL{}il1 il2
    

        iL1             OL      il2
      b1) 0 * nSize = OL(0)+0 + 0,1,2
          1 * nSize = OL(0)+9 + 0,1,2
          2 * nSize = OL(0)+18+ 0,1,2
    
     b2)  0 * nSize = OL(3)+0 = 3 + 0,1,2
          1 * nsize = OL(3)+9 = 12+ 0,1,2
          2 * nSize = OL(3)+18 = 21+ 0,1,2

     b3)  0 * nsize = OL(6)+0 = 6 + 0,1,2
          1 * nsize = OL(6)+9 = 6 + 0,1,2
          2 * nsize = OL(6)+18 = 6 + 0,1,2
    }
 // 

//-----------------------------------------------------------------------------
/// @brief Generates the board array and assigns the squares objects
///        *Note Square is not dynamic alloc. Because it's value being stored
///         in sub() or bd_m[x](which is dynamic memory).
//-----------------------------------------------------------------------------
void Board ::
getPuzzle() {
    char tempChar;
    cout << "Constructing Board..." << endl;
    for (int rowIter = 1; rowIter <= nSize_m; rowIter++) {
        for (int colIter = 1; colIter <= nSize_m; colIter++) {
            inFile_m >> tempChar;
            if (inFile_m.good()) {
                if ((tempChar >= '0' && tempChar <= '9') || (tempChar == '-')) {
                    sub(rowIter, colIter) = Square(tempChar, rowIter, colIter);
                    // cout << " [" << tempChar << "]: "  << "row: " << rowIter    //**Un-comment for debug
                    //      << " col: " << colIter;
                }
                else if (tempChar == '\n') {
                    // cout << "\n"  << "row: " << rowIter;                        //**Un-comment for debug
                }
                else {
                    cout << tempChar;
                    fatal("[!] ERROR - invald character in file: ");
                }
            }
            else if (inFile_m.eof()) {
                cout << endl;
                break;
            }
            else if (inFile_m.bad()) { 
                fatal("[!] Low-level error while reading input stream.");
            }
            cout << '\n';
        }
    }
}


//-----------------------------------------------------------------------------
/// @brief Calculates linear array coordinates from x,y
/// @param [in] row position on board
/// @param [in] col position on board
/// @return &reference to Square object on the Board's linear array
//-----------------------------------------------------------------------------
Square& Board::
sub(int row, int col) {return bd_m[(row - 1) * 9 + (col - 1)]; }


//-----------------------------------------------------------------------------
/// @brief Print display the values for all the Square*s stored in board
/// @param [out] os : reference stream object to store data
/// @return stream output object reference
//-----------------------------------------------------------------------------
ostream& Board :: 
print(ostream &os) {
    int bSize = (nSize_m * nSize_m);
    int nLine = (nSize_m - 1);

    /* The old print of printing the squares objects */
    for (int iter = 0; iter < (bSize); iter++) {
        os << bd_m[iter] <<" " << bd_m[iter].prState().str();
        if (iter % nSize_m == nLine) os << "\n";
    }
    return os;
}
