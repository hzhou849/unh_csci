//=============================================================================
// Square Class
//=============================================================================
#include "square.hpp"

Square ::  Square ( char charIn, short row, short col ) 
    : stateObj( charIn ), sqRow(row), sqCol(col) {
    cout << "Square: Row:" << sqRow << ", Col:" << sqCol << " constructed." << endl;
}

Square :: ~Square () { cout << "Deleting Square: " << sqRow << ", " << sqCol  <<endl; }


//-----------------------------------------------------------------------------
/// @brief - calls State class's mark() with new value for square
/// @param [in] newChar - new character to mark the state with
void Square :: 
mark(char newChar) {
    // Input validation moved to State::mark()

    char stateValue = stateObj.getValue();

    if (stateValue == '-') {
        cout << " [+] Possibilities BEFORE: " << stateObj << endl;
        stateObj.mark(newChar);
        cout << " [+] Possibilities AFTER: " << stateObj << endl;
    } 
    else {
        cout << " [+] State is already marked. Nothing to do" << endl;
    }
}

//-----------------------------------------------------------------------------
/// @brief Print the Square object values to an output stream
/// @param [in] os - output stream object of values to be printed
/// @return  the output stream object
ostream& Square :: 
print(ostream& os) {
    // print all of Square's members
    os << "Square: [" << sqRow  << ", " << sqCol <<  "]  " 
        << "Value: '" << stateObj.getValue() << "'  "    // Modify to state::print() later
        << "Possibilities: " << stateObj;

    return os;
}