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
State::State ( char param ): value(param)  {
    if ( isdigit(value) ) {
        posList = 0;
        fixed = true;
    } 
    else if ( value == ASCII_DASH ) {
        
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
}


//-----------------------------------------------------------------------------
// mark - prints error message if fixed is TRUE
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
// getValue - Returns the current state value
char State :: 
getValue () {
    return value;
}

// //-----------------------------------------------------------------------------
// // print  - allows us to print the object to a stream
// ostream& State ::
// printFull( ostream &os ) {
//     short tempValue = posList;
//     short binaryArr[10];

//     os << "\nHex value: " << showbase << hex << posList << "\n";
//     os << "\nBinary value: ";

//     // Reset the cout flags back to original (Decimal, no base)
//     cout << resetiosflags (ios::basefield);
      
//     // Start by shifting RIGHT once to discard first bit.
//     // Convert to binary starting at position 1
//     for ( int i=1; i < 10 ; i++ ) {
//         // Perform this first so we disregard bit 0.
//         tempValue = tempValue >> 1;   

//         if ( (tempValue & BIT_MASK) == 1 )  {
//             os << "1 ";
//             binaryArr[i] = i;
//         } 
//         else {
//             os << "0 ";
//             binaryArr[i] = '-';
//         }
//     }

//     // Print the array holding the binary positions
//     os <<"\nPosition:     ";
//     for ( int i=1; i< 10; i++ ) {
//         if (binaryArr[i] == '-') {
//             os << '-' << " ";
//         } 
//         else {
//             os << i << " ";
//         }
//     }
//     // Finish and flush the stream
//     os << endl;

//     return os;
// }

//-----------------------------------------------------------------------------
// Print
ostream& State :: 
print( ostream& os ) {
    short tempValue = posList;
    short binaryArr[10];

    // os << "\nHex value: " << showbase << hex << posList << "\n";
    // os << "\nBinary value: ";

    // Reset the cout flags back to original (Decimal, no base)
    cout << resetiosflags (ios::basefield);
      
    // // Start by shifting RIGHT once to discard first bit.
    // Convert to binary starting at position 1
    for ( int i=1; i < 10 ; i++ ) {
        // Perform this first so we disregard bit 0.
        tempValue = tempValue >> 1;   

        if ( (tempValue & BIT_MASK) == 1 )  {
            binaryArr[i] = i;
        } 
        else {
            binaryArr[i] = '-';
        }
    }

    // Print the array holding the binary positions
    os <<"\nPosition:     ";
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


//-----------------------------------------------------------------------------
// Square Constructor
Square :: Square ( char charIn, short row, short col ) 
    : stateObj( charIn ), sqRow(row), sqCol(col) {
    cerr << "Square: " << sqRow << ", " << sqRow << "constructed." << endl;
}

//-----------------------------------------------------------------------------
// Destructor
Square :: ~Square () {
    cerr << "Deleting Square: " << sqRow << ", " << sqCol << endl;
}

//-----------------------------------------------------------------------------
// Mark - calls State class's mark() with new value for square
void Square :: 
mark() {
    // print posList list before:

    // mark change state

    // print posList list after
}

//-----------------------------------------------------------------------------
// Print- calls State class's mark() with new value for square
ostream& Square :: 
print(ostream& os) {
    // print all of Square's members

    os << "Square: [" << sqCol  << ", " << sqRow <<  "] " 
        << "Value: " << stateObj.getValue()
        << " Possibilities: " << stateObj;

    //print the state using deligation state.print()
    // example: Square [4, 0] Value: - Possible: --765--21

    return os;
}