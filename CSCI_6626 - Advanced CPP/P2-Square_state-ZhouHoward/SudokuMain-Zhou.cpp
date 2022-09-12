// ---------------------------------------------------------------------------- 
// File:        main.cpp
// 
// Project:     P2 - Square - An entire square, composing a state.
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-06-2022
// Name:        Howard Zhou
// 
// 
// Description:
//              - Sudoku Project
// 
// ----------------------------------------------------------------------------

#include <iostream>
#include "state.hpp"

// ----------------------------------------------------------------------------
// Unit test 1 - Square State
void 
unitTest1() {
    char charValue = 12;

    // Unit test case 1:
    cout << "\n--------------- Unit Test Case 1: --------------------" << endl;
    State stateObj( '-' );
    stateObj.mark( charValue );
    std::cout << stateObj << endl;

    // Unit test case 2:
    cout << "\n--------------- Unit Test Case 2: --------------------" << endl;
    State stateObj2('9');
    stateObj2.mark( charValue );
    std::cout << stateObj2 << endl;
}

// ----------------------------------------------------------------------------
// Unit test 2 - Square
void 
unitTest2() {

    // Call State test first, then Square test.
    // she wants testSquare() and testState()
    State stateObj('-');
    Square sqObj('1', 4, 0);
    cout << sqObj << endl;
}

// ----------------------------------------------------------------------------
// Main driver function
int 
main (int argc, char* argv[]) {
    banner();
    // unitTest1();
    unitTest2();
    bye();
    
}