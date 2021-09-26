// CH6_Copy_Constructor.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
// CSCI 6620 - Data Structures
// Lecture week 4 - Chapter 6 Text Book
/*
 *
 *   Copy Constructor - SHALLOW COPY Example
 * 
 *  - When copying objects compiler will default memberwise copy.
 *  - Beware if you have a pointer data member, Pointer will be copied,
 *     NOT what it is pointing too (Shallow Copy).
 *   
 *  Best Practices:
 *  - Provide a copy constructor when your class has raw pointers.
 *  - Provide a copy constructor with const and pass-by-reference parameter (either & or *pointer)
 *  - use STL classes as they already provide copy constructors
 *  - Avoid using raw pointer data members if possible and use smart pointers.
 * 
 * Default Copy consturctor:
 *  - Memberwise copy
 *  - Each data member is copied from the source object
 *  - The pointer is copied, NOT what it is points to (shallow copy)
 * 
 *  - you will end up with a copy of the object both pointing to the same storage area in the heap
 * PROBLEM: Notice that in the display_player(Player P) function, the object created P will
 *          get deconstructed once it is out of scope. When we release the storage in the destructor, the other object
 *          is still pointing to this area and thinks it is good - which will lead to problems.
 *
 * 
 *  DEEP COPYING:
 *  - Create a copy of the pointed-to data
 *  - Each copy will have a pointer to unique storage in the heap
 *  - Always want to have a copy constructor to have Deep copy when you have a raw pointer as a class data member
 * 
 */

#include <iostream>

#include "Player.h"
#include "Shallow.h"
#include "Deep.h"



//----------------------------------------------------------------------------------------------------------------------
void display_player(Player p) 
{
    std::cout << "Name: "   << p.get_name() << std::endl;
    std::cout << "Health: " << p.get_health() << std::endl;
    std::cout << "XP: "     << p.get_xp() << std::endl;

    // When Object Player P goes out of scope, the destructor will be called.
}

void display_shallow(Shallow s)
{
    std::cout << s.get_data_value() << std::endl;
}

void display_deep(Deep d)
{
    std::cout << d.get_data_value() << std::endl;
}


int main()
{
    // Player class test
    //Player empty ("XXXX", 100, 50);

    //Player my_new_object(empty);
    //
    //// Because thisis a pass by value, the display_player(Player P) function
    //// will rely on the copy consturctor to create a copy on the stack memory.
    //display_player(empty);

    //Player frank { "Frank" }; 
    //Player hero  { "Hero", 100 };
    //Player villain { "Villain", 100, 55 };


    /*Shallow copy testing*/

    Shallow obj1 { 100 };
    display_shallow(obj1);

    Shallow obj2(obj1);
    
    // the issue here is we are going to reassign obj1.data to 1000
    // because obj2 is pointing to obj1 in the same address on heap
    obj2.set_data_value(1000); 

     //After this program ends, the destructor will crash wehn it tries to re-deleted the
     //address that was already deleted the first time it was called on obj1


    /*Deep Copy testing*/

    //Deep obj1{ 100 };
    //
    //// now when this is called, it will create another copy with a new address on heap to store data
    //// and deleting this out of scope, will not affect obj1
    //display_deep(obj1); 

    //Deep obj2{ obj1 };
    //obj2.set_data_value(999);

    return 0;
    
}

