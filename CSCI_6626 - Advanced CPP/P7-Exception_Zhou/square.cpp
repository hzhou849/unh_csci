//----------------------------------------------------------------------------- 
// File:         square.cpp
// 
// Project/ver:  P7 - Exception
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#include "square.hpp"
#include "cluster.hpp"      // For forward declaration

Square :: Square ( char charIn, short row, short col ) 
    : stateObj( charIn ), sqRow(row), sqCol(col) {
    cout << "Square: Row:" << sqRow << ", Col:" << sqCol << " constructed." << endl;
}

// Commented out for debugging
Square :: ~Square () { /*cout << "Deleting Square: " <<sqRow<< ", "<<sqCol<<endl;*/ }


//-----------------------------------------------------------------------------
/// @brief - calls State class's mark() with new value for square
/// @param [in] newChar - new character to mark the state with
//-----------------------------------------------------------------------------
void Square :: 
mark(char newChar) {
    char stateValue = stateObj.getValue();
    if (stateValue == '-') {
        cout << " [+] Possibilities BEFORE: " << stateObj << endl;
        stateObj.mark(newChar);
        cout << " [+] Possibilities AFTER: " << stateObj << endl;
    } 
    else { cout << " [+] State is already marked. Nothing to do" << endl; }
}

//-----------------------------------------------------------------------------
/// @brief  Called from Cluster class iterates this is sq's vec of Col/Row/Box
///         kick starts the process of removing value from possibilities list
//-----------------------------------------------------------------------------
void Square :: 
sqShoop() {
    if (stateObj.getValue() > '0') {
        for (Cluster* itc : clues_m) { itc->clShoop(stateObj.getValue()); }
    } else { cout << "\t[+] This square has no value - skipping.\n" << endl; }
}

//-----------------------------------------------------------------------------
/// @brief      Turn off position N from the possibilities list
/// @param[in] val - The number to disable from the list
//-----------------------------------------------------------------------------
void Square::turnOff( int val ) {
    cout << "   Square: " << sqRow << ", " << sqCol << ": ";
    stateObj.adjPlist(val);
}

//-----------------------------------------------------------------------------
/// @brief Print the Square object values to an output stream
/// @param [in] os - output stream object of values to be printed
/// @return  the output stream object
//-----------------------------------------------------------------------------
ostream& Square :: 
print(ostream& os) {
    // print all of Square's members
    os  << " [ " << sqRow  << ", " << sqCol <<  " ]" 
        << " Value: " << stateObj;
    return os;
}



