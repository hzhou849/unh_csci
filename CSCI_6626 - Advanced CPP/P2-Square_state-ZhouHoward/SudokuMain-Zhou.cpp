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

//-----------------------------------------------------------------------------
// Unit test P1 - State test
void 
p1_testState() {

    // State test 1
    char markTestVal1 = '5';
    cout << "\n-------- P1 -State - Running Unit Test (1 of 2) --------" << endl;
    State stateObj('-');
    cout << " Attemping to mark state with value: " << markTestVal1 << endl;
    cout << " [+] Possibilities (BEFORE): " << stateObj << endl;
    stateObj.mark( markTestVal1);
    cout << " [+] Possibilities (AFTER): " << stateObj << endl;

    // State test 2
    cout << "\n-------- P1 -State - Running Unit Test (2 of 2) --------" << endl;
    char markTestVal2 = '-';
    State stateObj2('0');
    cout << " Attemping to mark state with value: " << markTestVal2 << endl;
    cout << " [+] Possibilities (BEFORE): " << stateObj2 << endl;
    stateObj2.mark( markTestVal2 );
    cout << " [+] Possibilities (AFTER): " << stateObj2 << endl;
    cout << "**END OF P1 Unit Test - State--\n\n" << endl;




}

//-----------------------------------------------------------------------------
// Unit test P2 - Square
void 
p2_testSquare() {

    // P2 Unit test 1
    char markTestval1 = '1';
    cout <<"----- P2 Running Unit Test - Square (1 of 2) ------" << endl;
    Square sqObj1('-', 1, 4);
    cout << " [+] " << sqObj1 << endl;
    cout << "Attempting to mark state with new value: " << markTestval1 << endl;
    sqObj1.mark(markTestval1);

    // P2 unit test 2
    char markTestval2 = '8';
    cout <<"----- P2 Running Unit Test - Square (2 of 2) ------" << endl;
    Square sqObj2('0', 5, 7);
    cout << " [+] " << sqObj1 << endl;
    cout << "Attempting to mark state with new value: " << markTestval2 << endl;
    sqObj1.mark(markTestval2);
    cout << "**END OF P2 Unit Test - State--\n\n" << endl;



}

// ----------------------------------------------------------------------------
// Main driver function
int 
main (int argc, char* argv[]) {
    banner();
   
    // Unit tests
    p1_testState();
    p2_testSquare();

    bye();
}