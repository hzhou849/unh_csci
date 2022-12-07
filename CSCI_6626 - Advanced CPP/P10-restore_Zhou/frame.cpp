//----------------------------------------------------------------------------- 
// File:         frame.cpp
// 
// Brief:        Frame object to store all the states of the square each turn
// 
// Project/ver:  P10 - Restore
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#include "frame.hpp"



//-----------------------------------------------------------------------------
/// @brief Serialize objects to output file.
/// @param [in] gameOut - the stream/file to write the current game state to.
//-----------------------------------------------------------------------------
void Frame::serialize(ofstream& gameOut) {
    int bdSize = nSize * nSize;
    for (int itr=0; itr < (bdSize +1); ++itr) {
        gameOut.write( (char*) &arrState[itr], sizeof(State)); } 
}


//-----------------------------------------------------------------------------
/// @brief Realize read inputfile of backed-up state objects.
/// @param [in] gameIn - the stream/file to read the current game state to.
//-----------------------------------------------------------------------------
void Frame::realize(ifstream& gameIn) {
    int counter=0;
    State tempSt;
    string fileName = "savetest.txt";
    if (!gameIn.good()) { throw StreamErr("ERROR! Cannot open: " + fileName); }

    while (gameIn.good() ) { // this always reads 1 after
        gameIn.read( (char*) &tempSt, sizeof(tempSt) );

        if (counter > 80) { break;}
        else if ( gameIn.bad() ) { throw StreamErr("ERROR - read failed!"); }
        else if ( gameIn.eof() ){ cout << "eof detected" << endl; break; } 
    }
}


//-----------------------------------------------------------------------------
/// @brief iterates through member array[N] states of this Frame object
/// @param[out] os - Stream to return back for terminal output
//-----------------------------------------------------------------------------
ostream& Frame::print (ostream& os) { 
    int bSize = nSize * nSize;
    for (int itr=0; itr < bSize; ++itr) {
        if (itr % nSize == 0) { os << "\n"; }
        if (itr <= 9 ) { os << " (" << itr<<")"; } // pad single digit #
        else {  os <<"("<<itr<<")" ;} 
        os << arrState[itr] << " ";
    }
    os << "\n" << endl;
    return os;
}