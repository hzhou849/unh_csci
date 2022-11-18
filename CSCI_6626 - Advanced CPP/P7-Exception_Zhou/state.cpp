//----------------------------------------------------------------------------- 
// File:        state.cpp
// 
// Project/ver:  P7 - Exception
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-27-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------
#include "state.hpp"


// Constructor
/// @param initVal - initial state value
State :: State ( char initVal ): value(initVal)  {
    if ( value >= '0' && value <= '9') {
        posList = 0;
        fixed = true;
    } 
    else if ( value == '-') {
        // This means all 9-digits are still possible for this square.
        posList = 0x03FE;
        fixed = false;
    }
    cout << "State Object constructed with value: '" << value << "' "<< endl;
}


//-----------------------------------------------------------------------------
/// @brief - prints error message if fixed is TRUE
/// @param [in] charIn new character to mark the state 
//-----------------------------------------------------------------------------
void State :: 
mark ( char charIn ) {
    if ( (charIn < '0' || charIn > '9') && charIn != '-' ) {
        throw GmBadInputChar ( string(1, charIn) );
    }

    if ( fixed ) {
        cout << "Error State is fixed! "  << endl; //** Game error
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
void State :: adjPlist(int val) {
    cout << " before: " << *this << endl;
    posList &= ~(1 << val);         // mask out num @ postion val
    cout << "\t\t  after:  " << *this <<"\n" << endl;
}


//-----------------------------------------------------------------------------
/// @brief Retreive the current state's value
/// @return value=Returns the current state value
//-----------------------------------------------------------------------------
char State :: 
getValue () { return value; }


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
    cout << resetiosflags (ios::basefield); os << "'" << value <<"'" << "   ";  

    // Start by shifting RIGHT once to discard first bit.
    for ( int count=1; count < 10 ; count++ ) {
        tempValue = tempValue >> 1;             // Disregard bit 0.
        if ( (tempValue & BIT_MASK) == 1 )  { binaryArr[count] = count; } 
        else { binaryArr[count] = '-'; }
    }

    // Print the array holding the binary positions
    for ( int count=1; count< 10; count++ ) {
        if (binaryArr[count] == '-') { os << '-' << " "; } 
        else { os << count << " "; }
    }
    // ** For debugging, Finish and flush stream, and reset cout flags
    // os << std::hex << std::showbase<<" poslist: "<< posList << flush;
    // cout << resetiosflags (ios::basefield);
    return os;
}


