//=============================================================================
// Square Class
//=============================================================================
#include "square.hpp"
#include "cluster.hpp"      // For forward declaration

Square ::  Square ( char charIn, short row, short col ) 
    : stateObj( charIn ), sqRow(row), sqCol(col) {
    cout << "Square: Row:" << sqRow << ", Col:" << sqCol << " constructed." << endl;
}

Square :: ~Square () { cout << "Deleting Square: " <<sqRow<< ", "<<sqCol<<endl; }
// Square :: ~Square () { /*cout << "Deleting Square: " <<sqRow<< ", "<<sqCol<<endl; }


//-----------------------------------------------------------------------------
/// @brief - calls State class's mark() with new value for square
/// @param [in] newChar - new character to mark the state with
//-----------------------------------------------------------------------------
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
/// @brief  Called from Cluster class iterates this is sq's vec of Col/Row/Box
///         kick starts the process of removing value from possibilities list
//-----------------------------------------------------------------------------
// perhaps kicked off from Mark()???
// test case in cluster() to call a square's shoop()
//each cluster calls Square::shoop() -> cluster::shoop(val) -> square*::turnOff(num)
    //call from main
void Square :: 
shoop() {
    for (Cluster* itc : clues_m) {
        itc->shoop(stateObj.getValue());   // instead of getter, can I delegate base constructor values?
        // cout << "value test: " << value <<"; " << stateObj.getValue()<< endl;
    }
}

//-----------------------------------------------------------------------------
/// @brief      Turn off position N from the possibilities list
/// @param[in] val - The number to disable from the list
//-----------------------------------------------------------------------------
void Square::turnOff( int val ) {
    cout << "turning off: " << val << endl;

    stateObj.adjPlist(val); // deligate to state class
}



//-----------------------------------------------------------------------------
/// @brief Print the Square object values to an output stream
/// @param [in] os - output stream object of values to be printed
/// @return  the output stream object
//-----------------------------------------------------------------------------
ostream& Square :: 
print(ostream& os) {
    // print all of Square's members
    os << "[" << sqRow  << ", " << sqCol <<  "]"
        << " Value: " << stateObj
        << flush;

    return os;
}

//-----------------------------------------------------------------------------
/// @brief Full print of the Square::State objects values
/// @return  the output stream object state value & possibilities
//-----------------------------------------------------------------------------
stringstream Square ::
prState() {
    stringstream ss;
    ss << stateObj << flush;
    return ss; 
}

