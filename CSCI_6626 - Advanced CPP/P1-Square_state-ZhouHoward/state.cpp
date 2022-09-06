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
// Default Constructor
State::State() {}

//-----------------------------------------------------------------------------
// Overloaded Constructor
State::State(char param): value(param)  {

    if (std::isdigit(value)) {
        this->possibilities = 0;
        this->fixed = true;
    } 
    else if (value == '-') {
        // This means all 9-digits are still possible for this square.
        this->possibilities = 0x03FE;
        // this->possibilities = 0x023E;
        this->possibilities = 0x00F2;
        this->fixed = false;
    }
    else {
        fatal("Fatal error: undefined character entered!");
    }
}

//-----------------------------------------------------------------------------
// Destructor
State::~State() {};

//-----------------------------------------------------------------------------
// void
// State::mark(char ch) {

// };



//-----------------------------------------------------------------------------
ostream& 
State::print( ostream &os ) {

    const short BIT_MASK = 0x0001;              // Mask used for extracting last bit
    const short ASCII_DASH = 0x2D;              // ASCII rep for '-'

    short tempValue = this->possibilities;
    short binaryArr[10];

    os << "\nHex value: " << std::showbase << std::hex << this->possibilities << "\n";
    os << "\nBinary value: ";

    // Reset the cout flags back to original (Decimal, no base)
    std::cout << std::resetiosflags (std::ios::basefield);
    // Start by shifting RIGHT once to discard first bit.
      

    // Convert to binary starting at position 1
    for ( int i=1; i < 10 ; i++ ) {
        // Perform this first so we disregard bit 0.
        tempValue = tempValue >> 1;   

        // if ( (i >0) && ( (tempValue & BIT_MASK) == 1) ) {
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
    for (int i=1; i< 10; i++) {
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



//-----------------------------------------------------------------------------



