/* Shallow vs Deep Copy constructors */

/* Shallow Copy Constructor - no delegation
 * ex source.data = address0x123{5}
 * this->data will = address 0x123{5} too
 */
//Move::Move(const Move& source)
//	//:data(source.data) 
//{
//	// recall: int *data; is a pointer 
//	// this->data pointer = source.data pointer
//	// pointer = address of source.data
//	this->data = source.data;
//  std::cout << "Shallow copy called << std::endl;
//}


/* DEEP Copy Constructor - delegate to constructor
 * See here we are creating a whole new pointer on the heap with data
 * and just storing the actual dereference value in that pointer
 * NOT copying the pointer like shallow
 */
Move::Move(const Move& source)
	//: Move(*source.data) // delegate to constructor
{
 // this->data pointer =  *source.data pointer
	this->data = new int;

	// new address = same value of source
	*this->data = *source.data;
	std::cout << "Copy Constructor - Deep copy for: " << *data << std::endl;
}


#include <iostream>
#include "shallow.hpp"
#include "deep.hpp"

int main(int argc, char* argv[]) {
    // Shallow sObj(100);
    // display_shallow(sObj);

    // // Bad! becuase now sObj which has invalid data
    // // is  copied again into sObj2
    // Shallow sObj2(sObj);

    // // Now we are accidentally changing sObj and sObj2 to 1000;
    // // bad unless this is intentional
    // sObj2.setDataValue(1000); 

    // std::cout << sObj2.getDataValue() << std::endl;


    Deep dobj1 (99);
    display_deep(dobj1);

    Deep dobj2 (dobj1);
    dobj2.setDataValue(888);

    std::cout << dobj1.getDataValue() << "; "<< dobj2.getDataValue() << std::endl;

    

}
