// ---------------------------------------------------------------------------- 
// File:        main.cpp
// 
// Project:     P4 - Board
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


void test_arr(int* argArr ) {
    for (int i=0; i < 5; i++) {
        cout << argArr[i] <<endl;
    }

   
}
void test_arr2(int* argArr[] ) {
    cout << ":\n\nPrinting int pointers:" <<endl;
    for (int i=0; i < 5; i++) {
        cout << *argArr[i] <<endl;
    }

   
}


// subscript the array. For example, the following two declarations work properly together:
// enum class Color{ RED, BLUE, YELLOW };
// static const string colorStrings[3];
// The enum declaration belongs near the top of the .hpp file of the class that will use Colors. (Suppose
// that class is named Palette.) The data declaration goes in the .hpp of the Palette class, with a
// constexpr initializer.
// static constexpr string colorStrings[3] = {"red", "blue", "yellow"}; cpp
// Your job is to set up an analogous set of declarations for Box.
enum class Color { RED, BLUE, GREEN};
static const string colorStrings[3];

class Palatte{

public:
};
// static constexpr char* colorString[3] = {"red", "blue", "yellow"};



// // ----------------------------------------------------------------------------
// // Main driver function
int main (int argc, char* argv[]) {
    banner();
   
    if (argc < 2) fatal("Usage:  main <input filename>\n"); 
    cout << "Attempting to open file: " << argv[1] << endl;
    ifstream inputFile( argv[1] );
    
    if ( !inputFile.good() ) fatal("[!] ERROR - Unable to open file! " +string(argv[1]) + "\n");
    
    // Run game which will call Board inside the class
    Game gameObj(inputFile);
    gameObj.run();
    




    /*** DEBUGING STUFF ***/
    // int testArr[5] = {1,2,3,4,5};
    // int count = 0;

    // for (int i : testArr) {
    //     std::cout << "i: " << i << endl;
    //     i = count++;
    // }

    // test_arr(testArr);


    // int* testArr2[5];
    // int a1 = 1;
    // int a2 = 2;
    // int a3 = 3;
    // int a4 = 4;
    // int a5 = 5;

    // testArr2[0] = &a1;
    // testArr2[1] = &a1;
    // testArr2[2] = &a1;
    // testArr2[3] = &a1;
    // testArr2[4] = &a1;
    // // testArr2[0] = &a1;
    // // testArr2[1] = &a2;
    // // testArr2[2] = &a3;
    // // testArr2[3] = &a4;
    // // testArr2[4] = &a5;

    // test_arr2(testArr2);


    bye();

    
}

