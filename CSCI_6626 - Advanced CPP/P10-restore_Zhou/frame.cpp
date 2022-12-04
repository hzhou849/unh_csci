
//=============================================================================
// Frame Implementation
//=============================================================================
#include "frame.hpp"
//-----------------------------------------------------------------------------
/// @brief Game - Constructor
/// @param [in] gameOut - the stream/file to write the current game state to.
//-----------------------------------------------------------------------------
void Frame::serialize(ofstream& gameOut) {
    gameOut << "testing saving stuff " << endl;
    gameOUt << arrState[1].
    gameOut << *this << endl;
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