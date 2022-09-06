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

void unitTest1() {
    State stateObj('-');

    std::cout << stateObj << std::endl;
}


int main (int argc, char* argv[]) {
    banner();
    
    unitTest1();

    bye();
    
}