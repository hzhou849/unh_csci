//-----------------------------------------------------------------------------
// File:         board.hpp
//
// Brief:        Generate the board of squares
//
// Project/ver:  P7 - Exception
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

#include "board.hpp"

//-----------------------------------------------------------------------------
/// @brief Constructor - Board handles creating 3* N clusters of N Sq* each
/// @param[in] type    - Board type (t)raditional, (d)diag, (s)ixy
/// @param[in] puzFile - input file containing board_type and sq values.
/// @param[in] numClus - number of clusters default is 27 or 29 for diag
//-----------------------------------------------------------------------------
Board :: Board(char type, ifstream &puzFile ) : inFile_m(puzFile) {
    if (type == 't' || type == 'd') { nSize_m = 9; }
    else { nSize_m = 6; }

    arrSqs_m = new Square[nSize_m * nSize_m];
    getPuzzle();
    mkCluster();
}

//-----------------------------------------------------------------------------
/// @brief Helper function to kickoff creating all row,column and box clusters
//-----------------------------------------------------------------------------
void Board ::
mkCluster() {
    Square *tempArr[9]; // As per instructions re-use this local array for all 27 cluster

    /* Create Row/Column/Box clusters */
    for (int row = 0; row < nSize_m; ++row)
        crtRow(row, tempArr);
    for (int col = 0; col < nSize_m; ++col)
        crtColumn(col, tempArr);
    for (int box = 0; box < nSize_m; ++box)
        crtBox(box, tempArr);
    cout << "\n===============================================================\n"
         << "Board() printing full cluster set:\n" << endl;

    for (Cluster *itc : clus_m) { cout << *itc << endl; }
}

//-----------------------------------------------------------------------------
/// @brief Temporary function to test shoop features
//-----------------------------------------------------------------------------
void Board::bdShoop() {
    int bdSize = nSize_m * nSize_m;
    for (int itr=0; itr <bdSize; ++itr) { 
            cout << "Performing Shoop() on square: " << arrSqs_m[itr] << endl;
            arrSqs_m[itr].sqShoop(); 
    }
}

//-----------------------------------------------------------------------------
/// @brief Calculate all the N ROWS sqs, pushes row clusters 
///        into vector clus_m
/// @param[in] curRow - Current Row counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the row's N square*
//-----------------------------------------------------------------------------
void Board ::
crtRow (int curRow, Square *tempArr[]) {
    int sqCell;
    for (int it = 0; it < nSize_m; ++it) {
        sqCell = ((curRow * nSize_m) + it);
        tempArr[it] = &arrSqs_m[sqCell];
    }
    clus_m.push_back(new Cluster(ClusterT::ROW, tempArr));
}

//-----------------------------------------------------------------------------
/// @brief Calculate all the N COLUMNS sqs, pushes col clusters 
///        into vector clus_m
/// @param[in] curCol - Current column counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the col's N square*
//-----------------------------------------------------------------------------
void Board ::
crtColumn (int curCol, Square *tempArr[]) {
    int sqCell;
    for (int it = 0; it < nSize_m; ++it) {
        sqCell = (it * nSize_m) + curCol;
        tempArr[it] = &arrSqs_m[sqCell];
    }
    clus_m.push_back(new Cluster(ClusterT::COLUMN, tempArr));
}

//-----------------------------------------------------------------------------
/// @brief Calculate all the N BOX sq and push box clusters into vector clus_m
/// @param[in] curBox - Current Box counter offset (0-indexed)
/// @param[in] tempArr - Temparary array used to hold the col's N square*
//-----------------------------------------------------------------------------
void Board ::
crtBox(int curBox, Square *tempArr[]) {

    int count=0;
    int startSq; int sqCell;
    // #rows of each sq per line in a box & columns of Boxes on board (9)=3; (6)=2 
    int rowPerBox = nSize_m / 3, numBoxRows = rowPerBox;   
    int sqBdRow;                   // Total number sq in a full board row. (9)27 or (6)12
    int boxColPos;                 // This Box's column position on board's current row
                                    // for board size 9 (left, mid, right) = 3
                                    // for board size 6 (left, right) = 2
    if (nSize_m == 9) { sqBdRow = 27; boxColPos = curBox % 3; }
    else { sqBdRow = 12; boxColPos=curBox % 2; }

    startSq = (floor(curBox / numBoxRows) * sqBdRow) + (boxColPos * 3);

    // Cycle 3 times for 3 rows each square within a box
    for (int outItr = 0; outItr < rowPerBox; ++outItr) {
        for (int iter = 0; iter < 3; ++iter) {  
            sqCell = (outItr * nSize_m) + startSq + iter;
            tempArr[count++] = &arrSqs_m[sqCell];
            }
        }
    clus_m.push_back(new Cluster( ClusterT::BOX, tempArr ) );
    }


//-----------------------------------------------------------------------------
/// @brief Generates the board array and assigns the squares objects
///        *Note Square is not dynamic alloc. Because it's value being stored
///         in sub() or arrSqs_m[x](which is dynamic memory).
//-----------------------------------------------------------------------------
void Board ::
getPuzzle () {
    char tempChar;
    cout << "Constructing Board..." << endl;
    for (int rowIter = 1; rowIter <= nSize_m; rowIter++) {
        for (int colIter = 1; colIter <= nSize_m; colIter++) {
            inFile_m >> tempChar;
            if (inFile_m.good()) {
                if ((tempChar >= '0' && tempChar <= '9') || (tempChar == '-')) {
                    sub(rowIter, colIter) = Square(tempChar, rowIter, colIter);
                    // cout << " [" << tempChar << "]: "  << "row: " << rowIter    //**Un-comment for debug
                }
                else if (tempChar == '\n') {
                    // cout << "\n"  << "row: " << rowIter;  //**Un-comment for debug
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
Square& Board ::
sub (int row, int col) { 
    return arrSqs_m[(row - 1) * nSize_m + (col - 1)]; }


//-----------------------------------------------------------------------------
/// @brief mark the assigned sq and perform shoop()
///        validation for row/col input is performed here
/// @param[in] row   Square row  (1 to nSize_m)
/// @param[in] col   Square's column (1 to nSize_m)
/// @param[in] value Square value; this is validated in state class
/// @return  true=succes false=failure
//-----------------------------------------------------------------------------
void Board :: 
mark (char row, char col, char value) {
    int rowNum, colNum, sqCell;
    int maxSq = (nSize_m * nSize_m) - 1;  // array of sq is 0-indexed

    rowNum = row - '0';
    colNum = col - '0';
    sqCell = ( (rowNum-1) * nSize_m ) + (colNum -1); // minus 1 for 0-indexed arrays

    cout << "\nMarking Square: " << rowNum << "; " << colNum  << "; sq: " <<sqCell << endl;

    if (sqCell < 0 || sqCell > (maxSq) ) {
        cout << "Invalid row/column data entered. Aborting Mark..." << endl;
        return;
    }

    arrSqs_m[sqCell].mark(value);
    arrSqs_m[sqCell].sqShoop();
}


//-----------------------------------------------------------------------------
/// @brief Print display the values for all the Square*s stored in board
/// @param [out] os : reference stream object to store data
/// @return stream output object reference
//-----------------------------------------------------------------------------
ostream& Board ::
print (ostream &os) const{
    int bSize = (nSize_m * nSize_m);
    int nLine = (nSize_m - 1);

    /* The old print of printing the squares objects */
    for (int iter = 0; iter < (bSize); iter++) {
        os << arrSqs_m[iter] << "\n";
        if (iter % nSize_m == nLine) os << "\n";
    }
    return os;
}
