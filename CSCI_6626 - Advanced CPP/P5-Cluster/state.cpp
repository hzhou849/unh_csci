//----------------------------------------------------------------------------- 
// File:        state.cpp
// 
// Project:     P4 - Board
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-27-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------
#include "state.hpp"

//=============================================================================
// Square Class
//=============================================================================

// Constructor
/// @param initVal - initial state value
State :: 
State ( char initVal ): value(initVal)  {
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
/// @brief - prints error message if fixed is TRUE
/// @param [in] charIn new character to mark the state 
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
/// @brief Adjust the possibilities list by removing value pos.list
//-----------------------------------------------------------------------------
void State::adjPlist(int val) {
    cout << "AdjPlist() - posList: " << *this;
    posList &= ~(1 << val);
    cout << "after: " << *this << endl;

    //0x03fe
    //         98 7654 321 0
    //  0000 0011 1111 111 0
    //  0000 0000 0010 000 0
    //  1111 1111 1101 111 1
}

//-----------------------------------------------------------------------------
/// @brief Retreive the current state's value
/// @return value=Returns the current state value
//-----------------------------------------------------------------------------
char State :: 
getValue () {
    return value;
}

//-----------------------------------------------------------------------------
/// @brief Print the state values and possibilities list
/// @param [in] os - Ostream object for data to be appended to
/// @return the os object with the data
//-----------------------------------------------------------------------------
ostream& State :: 
print( ostream& os ) {
    short tempValue = posList;
    short binaryArr[10];

    // Reset the cout flags back to original (Decimal, no base)
    cout << resetiosflags (ios::basefield);
    os << "'" << value <<"'" << "  ";  
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
    os << std::hex << std::showbase<<" poslist: "<<posList << endl;
    cout << resetiosflags (ios::basefield);
    // os << endl;
    // os << flush; // to not have newline

    return os;
}

