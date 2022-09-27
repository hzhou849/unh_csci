// ---------------------------------------------------------------------------- 
// File:        main.cpp
// 
// Project:     P3 - Square
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-20-2022
// Name:        Howard Zhou
// 
// 
// Description:
//              - Sudoku Project
// 
// ----------------------------------------------------------------------------

#include <iostream>
#include "state.hpp"
#include "game.hpp"

// Unit test P1 - State test
//-----------------------------------------------------------------------------
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

// Unit test P2 - Square
//-----------------------------------------------------------------------------
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

    cout << " [+] " << sqObj2 << endl;
    cout << "Attempting to mark state with new value: " << markTestval2 << endl;
    
    sqObj2.mark(markTestval2);
    cout << "**END OF P2 Unit Test - State--\n\n" << endl;
}


/// @brief Unit Test 3 - Game class - File IO test
/// @param [in] argCount - number of args passed from cmd-line
/// @param [in] argName - Name of text file to read from
// ----------------------------------------------------------------------------
void
p3_gameTest(int argCount, const char* argName) {
    // Check to make sure file name is passed as command-line arg
    if (argCount < 2) fatal("Usage:  main <input filename>\n"); 
    
    cout << "Attempting to open file: " << argName << endl;
    ifstream inputFile( argName );

    if ( !inputFile ) fatal("[!] ERROR - Unable to open file!]n");
    
    Game gameObj(inputFile);
    gameObj.run();
}


// ----------------------------------------------------------------------------
// Main driver function
int 
main (int argc, char* argv[]) {
    banner();
   
    /* Unit tests */
    // p1_testState();
    // p2_testSquare();
  
    p3_gameTest(argc, argv[1]);
    
    bye();
}