//----------------------------------------------------------------------------- 
// File:        state.cpp
// 
// Project:     P2 - Square
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-11-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------
#include "state.hpp"

//=============================================================================
// Square Class
//=============================================================================

//-----------------------------------------------------------------------------
// Constructor
/// @param initVal - initial state value
State::State ( char initVal ): value(initVal)  {
    if ( value >= '0' && value <= '9') {
        posList = 0;
        fixed = true;
    } 
    else if ( value == '-') {
        
        // This means all 9-digits are still possible for this square.
        // *here are the 3 examples from the instructions
        posList = 0x03FE;
        // this->possibilities = 0x023E;
        // this->possibilities = 0x00F2;
        
        fixed = false;
    }
    else {
        fatal ( "Fatal error: undefined character entered!" );
    }

    cerr << "State Object constructed with value: '" << value << "' "<< endl;
}


//-----------------------------------------------------------------------------
// mark - prints error message if fixed is TRUE
// @param charIn
void State :: 
mark ( char charIn ) {


    if ( (charIn < '0' || charIn > '9') && charIn != '-' ) {
        fatal( "Invalid input character passed!");
    }

    if ( fixed ) {
        cerr << "Error in: " << __func__ << "() State is fixed! "  << endl;
    } 
    else {
        value = charIn;
        cout << "State is NOT fixed, value re-assigned: " << value << endl;

        // Possibilites is now assigned to zero
        posList = 0;
    }
}

//-----------------------------------------------------------------------------
// getValue - Returns the current state value
char State :: 
getValue () {
    return value;
}

//-----------------------------------------------------------------------------
// Print
ostream& State :: 
print( ostream& os ) {
    short tempValue = posList;
    short binaryArr[10];

    // Reset the cout flags back to original (Decimal, no base)
    cout << resetiosflags (ios::basefield);
      
    // Start by shifting RIGHT once to discard first bit.
    // Convert to binary starting at position 1
    for ( int count=1; count < 10 ; count++ ) {
        // Perform this first so we disregard bit 0.
        tempValue = tempValue >> 1;   

        if ( (tempValue & BIT_MASK) == 1 )  {
            binaryArr[count] = count;
        } 
        else {
            binaryArr[count] = '-';
        }
    }

    // Print the array holding the binary positions
    // os <<"Possibility list: ";
    for ( int count=1; count< 10; count++ ) {
        if (binaryArr[count] == '-') {
            os << '-' << " ";
        } 
        else {
            os << count << " ";
        }
    }
    // Finish and flush the stream
    os << endl;

    return os;
}


//=============================================================================
// Square Class
//=============================================================================

/// @brief Square Constructor
/// @param [in] charIn - Character 0-9 or '-' for the square
/// @param [in] row positon on the board
/// @param [in] col column position on the board
//-----------------------------------------------------------------------------
Square :: Square ( char charIn, short row, short col ) 
    : stateObj( charIn ), sqRow(row), sqCol(col) {
    cerr << "Square: Row:" << sqRow << ", Col:" << sqCol << " constructed." << endl;
}

// Destructor
//-----------------------------------------------------------------------------
Square :: ~Square () {
    cerr << "Deleting Square: " << sqRow << ", " << sqCol << endl;
}

/// @brief calls State class's mark() with new value for square
/// @param [in] newChar the new character to repalce current square with
//-----------------------------------------------------------------------------
void Square :: 
mark(char newChar) {
    if ( (newChar < '0' || newChar > '9') && newChar != '-' ) {
        fatal( "Invalid input character passed!");
    }

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

/// @brief Print -  calls State class's mark() with new value for square
/// @param [in] os stream to store data values
/// @return data stream for output
//-----------------------------------------------------------------------------
ostream& Square :: 
print(ostream& os) {
    // print all of Square's members
    os << "Square: [" << sqRow  << ", " << sqCol <<  "]  " 
        << "Value: '" << stateObj.getValue() << "'  "
        << "Possibilities: " << stateObj;

    return os;
}