// MoveConstructor.cpp : This file contains the 'main' function. Program execution begins and ends there.
/* Demo of Deep/Shallow and Move constructors */

#include <iostream>
#include <vector>
#include "Move.h"


int main() 
{
    // Test copying
    //Move mObj(5);
    //Move mObj2(mObj);  // Copy constructor gets called, not default
    //std::cout << "val: " << mObj.getVal() << std::endl;

    // Test Move constructor - create the object then push back to vector
    std::vector<Move> mobj;
    mobj.push_back( Move{ 10 } );
    mobj.push_back( Move{ 20 } );
    mobj.push_back( Move{ 30 } );
    mobj.push_back( Move{ 40 } );
}


/*
 * Using deep copy
Constructor for : 0109E920 {10}
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


==== Using Move semantics =====
Constructor for : 0x56f924= 00886190 {10}
 Move from old pointer: 0056F924 Constructor to new pointer: 0088E318 {10}@00886190
[*] Destructor: 5699876={nullptr}
Constructor for : 0x56f914= 00885398 {20}
 Move from old pointer: 0056F914 Constructor to new pointer: 008861C8 {20}@00885398
 Move from old pointer: 0088E318 Constructor to new pointer: 008861C0 {10}@00886190
[*] Destructor: 0xcdcdcdcd={nullptr}
[*] Destructor: 0x56f914={nullptr}
Constructor for : 0x56f904= 008853F8 {30}
 Move from old pointer: 0056F904 Constructor to new pointer: 00890170 {30}@008853F8
 Move from old pointer: 008861C0 Constructor to new pointer: 00890160 {10}@00886190
 Move from old pointer: 008861C8 Constructor to new pointer: 00890168 {20}@00885398
[*] Destructor: 0xcdcdcdcd={nullptr}
[*] Destructor: 0xcdcdcdcd={nullptr}
[*] Destructor: 0x56f904={nullptr}
Constructor for : 0x56f8f4= 008861C0 {40}
 Move from old pointer: 0056F8F4 Constructor to new pointer: 00890758 {40}@008861C0
 Move from old pointer: 00890160 Constructor to new pointer: 00890740 {10}@00886190
 Move from old pointer: 00890168 Constructor to new pointer: 00890748 {20}@00885398
 Move from old pointer: 00890170 Constructor to new pointer: 00890750 {30}@008853F8
[*] Destructor: 0xcdcdcdcd={nullptr}
[*] Destructor: 0xcdcdcdcd={nullptr}
[*] Destructor: 0xcdcdcdcd={nullptr}
[*] Destructor: 0x56f8f4={nullptr}
Destructor for : 00886190 {0xa}
Destructor for : 00885398 {0x14}
Destructor for : 008853F8 {0x1e}
Destructor for : 008861C0 {0x28}
*/


