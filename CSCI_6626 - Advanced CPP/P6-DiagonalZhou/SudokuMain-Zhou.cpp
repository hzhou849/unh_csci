// ---------------------------------------------------------------------------- 
// File:        main.cpp
// 
// Project:     P5 - Cluster
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
// ----------------------------------------------------------------------------

#include <iostream>
#include "state.hpp"
#include "game.hpp"
#include "board.hpp"

// Testing
// #include "cluster.hpp"
// class Square;
// #include "square.hpp"


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

    cout << " [+] " << sqObj2 << endl;
    cout << "Attempting to mark state with new value: " << markTestval2 << endl;
    
    sqObj2.mark(markTestval2);
    cout << "**END OF P2 Unit Test - State--\n\n" << endl;
}


// ----------------------------------------------------------------------------
// Main driver function
int main (int argc, char* argv[]) {
    banner();
   
    if (argc < 2) fatal("Usage:  main <input filename>\n"); 
    cout << "Attempting to open file: " << argv[1] << endl;
    ifstream inputFile( argv[1] );
    
    if ( !inputFile.good() ) fatal("[!] ERROR - Unable to open file! " +string(argv[1]) + "\n");
    
    // Run game which will call Board inside the class
    Game gameObj(inputFile);
    gameObj.run();

    bye();
}

