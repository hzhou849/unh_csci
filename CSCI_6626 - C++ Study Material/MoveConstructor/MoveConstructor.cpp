// MoveConstructor.cpp : This file contains the 'main' function. Program execution begins and ends there.

#include <iostream>
#include <vector>
#include "Move.h"


// Copy constructor - Shallow
// Shallow::Shallow(int d) {
//    : data(source.data)
//  which is this->data = source.data
//}

int main() 
{
    // Test copying
    //Move mObj(5);
    //Move mObj2(mObj);  // Copy constructor gets called, not default
    //std::cout << "val: " << mObj.getVal() << std::endl;

    // Test Move constructor
    std::vector<Move> mobj;
    mobj.push_back(Move{ 10 });
    mobj.push_back(Move{ 20 });
    mobj.push_back(Move{ 30 });
    mobj.push_back(Move{ 40 });

    /*Constructor for : 0109E920 {10}
Copy Constructor - Deep copy for new pointer: 0109ECD0 {10}
Destructor for : 0109E920 {10}
Constructor for : 0109E920 {20}
Copy Constructor - Deep copy for new pointer: 01095420 {20}
Copy Constructor - Deep copy for new pointer: 01095450 {10}
Destructor for : 0109ECD0 {10}
Destructor for : 0109E920 {20}
Constructor for : 0109ECD0 {30}
Copy Constructor - Deep copy for new pointer: 01095480 {30}
Copy Constructor - Deep copy for new pointer: 0109E920 {10}
Copy Constructor - Deep copy for new pointer: 0109E950 {20}
Destructor for : 01095450 {10}
Destructor for : 01095420 {20}
Destructor for : 0109ECD0 {30}
Constructor for : 0109ECD0 {40}
Copy Constructor - Deep copy for new pointer: 01095160 {40}
Copy Constructor - Deep copy for new pointer: 01095190 {10}
Copy Constructor - Deep copy for new pointer: 010951C0 {20}
Copy Constructor - Deep copy for new pointer: 010A22F0 {30}
Destructor for : 0109E920 {10}
Destructor for : 0109E950 {20}
Destructor for : 01095480 {30}
Destructor for : 0109ECD0 {40}
Destructor for : 01095190 {10}
Destructor for : 010951C0 {20}
Destructor for : 010A22F0 {30}
Destructor for : 01095160 {40}

The output for this vectors is like this because the vector
keeps moving to a new location so that it can grow the vector.

It basically goes to new item address and continues from there.
so if item[1] is address 0x02 and item[2] is 0x04, lets say
item[3] gets allocated in 0x08, it will copy item[1] to 0x0A and item[2] to 0x0C
so that it is contiguous with new memory address.
*/
}


