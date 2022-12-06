
//=============================================================================
// Frame Implementation
//=============================================================================
#include "frame.hpp"
//-----------------------------------------------------------------------------
/// @brief Game - Constructor
/// @param [in] gameOut - the stream/file to write the current game state to.
//-----------------------------------------------------------------------------
void Frame::serialize(ofstream& gameOut) {
    int bdSize = nSize * nSize;

    for (int itr=0; itr < (bdSize +1); ++itr) {
        gameOut.write( (char*) &arrState[itr], sizeof(State)) ;
    } 
    // gameOut.write( (char*) &arrState[79], sizeof(arrState[0])) ;
    // gameOut.write( (char*) &arrState[80], sizeof(arrState[0])) ;
    // gameOut.write( (char*) &arrState[2], sizeof(arrState[2])) ;
    // gameOut << *this << endl;





}

void Frame::realize(ifstream& gameIn) {
    State tempSt;
    int counter=0;


    string fileName = "savetest.txt";
    if (!gameIn.good()) { throw StreamErr(" gameIn ERROR!!" + fileName); }

    while (gameIn.good() ) { // this always reads 1 after
        gameIn.read( (char*) &tempSt, sizeof(tempSt) );

        if (counter > 80) { break;}
        else if (gameIn.eof()){ cout << "eof detected" << endl; break; } 
        else {
            arrState[counter] = tempSt;
            cout << counter << ") " <<  "Frame print: From file: " << arrState[counter] <<endl;
            counter++;

        }
    }

}

ostream& Frame::print (ostream& os) { 
    int bSize = nSize * nSize;
    for (int itr=0; itr < bSize; ++itr) {
        if (itr % nSize == 0) {
            os << "\n";
        }
        if (itr <= 9 ) { os << " (" << itr<<")"; } // pad single digit #
        else {  os <<"("<<itr<<")" ;} 
        os << arrState[itr] << " ";
    }
    os << "\n" << endl;
    return os;
}