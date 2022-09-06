/* ---------------------------------------------------------------------------- 
 * File:        main.cpp
 * 
 * Project:     P1 - Square State
 * Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
 * Professor:   Dr. Alice E. Fischer
 * Due Date:    09-06-2022
 * Name:        Howard Zhou
 * 
 * 
 * Description:
 *              First Assignment
 * 1) Define a class STATE and implement:
 *  - data members in this order: short possibilities; char value; boolean fixed.
 *  - A default null constructor
 *  - A constructor with a char parameter, initialize the value to the parameter 
 *      (a dash or a single digit).
 *    -If the value is a digit, initialize the possibility list to 0 and 
 *      the fixed flag to true
 *     - If it is a ‘-’, initialize the fixed flag to false and the possibility 
 *       list to 0x3fe (In binary, 0000 0011 1111 1110.)
 * 2) 
 * 
 *----------------------------------------------------------------------------- 
 */ 

#include <iostream>
#include "state.hpp"
// #include "tools.hpp" included in state.hpp

void // -----------------------------------------------------------------------
unitTest1() {
    char charValue = 12;

    // Unit test case 1:
    cout << "\n--------------- Unit Test Case 1: ---------------------" << endl;
    State stateObj( '-' );
    stateObj.mark( charValue );
    std::cout << stateObj << endl;

    // Unit test case 2:
    cout << "\n--------------- Unit Test Case 2: ---------------------" << endl;
    State stateObj2('9');
    stateObj2.mark( charValue );
    std::cout << stateObj2 << endl;
}


int // ------------------------------------------------------------------------
main (int argc, char* argv[]) {
    banner();
    
    unitTest1();

    bye();
    
}