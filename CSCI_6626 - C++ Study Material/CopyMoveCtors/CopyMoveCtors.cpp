/*
	Copy / Move Constructors
	This program will crash and demonstrate why shallow copies will not work
	if you are using pointers and dynamic heap allocated memory
*/ 

#include <iostream>
#include "shallow.h"

int main()
{
	// LValue = obj1
	Shallow obj1{ 100 }; // Obj1-><address1>=100

	/* Problem arises here bc the copy constructor will be called due to pass-by-value
		but once this function is out of scope, destructor for the passbyVal will get called
		resulting in marking deletion of address1. Therefore address1->invalid data.
		The data will still remain on the heap, but is no longer valid data
	*/
	displayShallow(obj1);  

	// Pointer of address1 at this point is invalid, its already been deleted
	// Now we made a copy of invalid data, which will still work up until this point
	Shallow obj2{ obj1 };

	// A second issue of shallow copying is bc both obj1 &obj2 are pointing to the same address1
	// you risk accidentally changing both values here bc they are pointing to the same location
	// obj1 & obj2 is now 1000
	obj2.setData(1000);


	// When we start to un-roll the stack and destructor is called, it will crash bc address1
	// has already been freed accidently when displayShallow() terminated
	// Destructor cannot be called on address1 bc it is an invalid location.
	return 0;
}

