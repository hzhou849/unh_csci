// ---------------------------------------------------------------------------- 
// File:        main.cpp
// 
// Project:     P1 - Square State
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-06-2022
// Name:        Howard Zhou
// 
// 
// Description:
//   - In this first assignment we are creating the State class and 
//     initializing its member functions/variables.
// 
// ----------------------------------------------------------------------------

#include <iostream>
#include "state.hpp"

// ----------------------------------------------------------------------------
// Unit test 1 - Helper function
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
// Main driver function
int 
main (int argc, char* argv[]) {
    banner();
    unitTest1();
    bye();
    
}