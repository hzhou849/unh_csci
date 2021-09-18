// CSCI 6620 - Data Structures
//
// CH6_Circular_linked_lsit.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
// Test program to Demostrate c++ template and a circular linked list
// Linked list is taken from CH3 and modified for Template and circular linked list

/*
* Note with templates, The compiler cannot instantiate a fucntion template unless it knows the actual
* parameter to the template and teh this acutal parameter apperies in the client code
* Which is why you cannot put class definition in header and member function definition in cpp file 
 */
#include <iostream>

#include "ItemType.h"


/// Template testing 
/// 
/// @Tparam - ItemType Template parameter
/// 
template <class ItemType>
class StackType
{
public:
    StackType() {}
    ItemType initStack(ItemType value)
    {
        std::cout << "ItemType passed: " << value << std::endl;
        
        return value;
    }
};


int main()
{
    // Testing of template class
    StackType<int> myStack;
    myStack.initStack(20);

}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
