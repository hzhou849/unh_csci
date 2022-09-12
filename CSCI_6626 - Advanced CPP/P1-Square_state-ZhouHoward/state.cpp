//----------------------------------------------------------------------------- 
// File:        state.cpp
// 
// Project:     P1 - Square State
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-06-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------
#include "state.hpp"


//-----------------------------------------------------------------------------
// Constructor
State::State ( char param ): value(param)  {
    if ( isdigit(value) ) {
        posList = 0;
        fixed = true;
    } 
    else if ( value == '-' ) {
        
        // This means all 9-digits are still possible for this square.
        // *here are the 3 examples from the instructions
        posList = 0x03FE;
        // this->posList = 0x023E;
        // this->posList = 0x00F2;
        
        fixed = false;
    }
    else {
        fatal ( "Fatal error: undefined character entered!" );
    }
}


//-----------------------------------------------------------------------------
// mark() function - prints error message if fixed is TRUE
void State :: 
mark ( char ch ) {
    if ( fixed ) {
        cout << "Error in: " << __func__ << "() State is fixed! "  << endl;
    } 
    else {
        ch = value;
    }
}

//-----------------------------------------------------------------------------
// print()  - allows us to print the object to a stream
ostream& State ::
print( ostream &os ) {
    short tempValue = posList;
    short binaryArr[10];

    os << "\nHex value: " << showbase << hex << posList << "\n";
    os << "\nBinary value: ";

    // Reset the cout flags back to original (Decimal, no base)
    cout << resetiosflags (ios::basefield);
      

    // Start by shifting RIGHT once to discard first bit.
    // Convert to binary starting at position 1
    for ( int i=1; i < 10 ; i++ ) {
        // Perform this first so we disregard bit 0.
        tempValue = tempValue >> 1;   

        if ( (tempValue & BIT_MASK) == 1 )  {
            os << "1 ";
            binaryArr[i] = i;
        } 
        else {
            os << "0 ";
            binaryArr[i] = '-';
        }
    }

    // Print the array holding the binary positions
    os <<"\nPosition:     ";
    for ( int i=1; i< 10; i++ ) {
        if (binaryArr[i] == ASCII_DASH) {
            os << '-' << " ";
        } 
        else {
            os << i << " ";
        }
    }
    // Finish and flush the stream
    os << endl;

    return os;
}




