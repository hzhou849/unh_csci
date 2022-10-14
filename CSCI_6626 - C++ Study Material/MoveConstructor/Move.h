/* Move Constructor
 * Instead of making deep copies on the heap, it moves the resource
 * Simply copies the address of the resource from source to the current object
 * and nulls out the pointer in the source pointer
 * 
 *  Very efficient
 * 
 * No const param because we need to change it.
 */

#pragma once
#include <iomanip>

class Move
{
private:
	int *data;
	int oldPtrAdd;

public:
	Move(int d);
	~Move();

	// Copy Constructor
	Move(const Move& source);    // - L-Value

	// Move Constructor
	Move(Move &&source) noexcept; // param is R-Value

	void setVal(int d) { *data = d; }
	int getVal() { return *data;  }

};

// Constructor
Move::Move(int d = 0) {
	// Create a new pointer on the heap
	// and dereference and store int d
	data = new int; 
	*data = d;
	oldPtrAdd = reinterpret_cast<int>(&data);
	std::cout << std::hex << std::showbase 
			  << "Constructor for : " <<oldPtrAdd << "= " << this->data 
			  <<std::dec << " {" << d << "}" << std::endl;
}

// Destructor
Move::~Move() {
	if (this->data != nullptr) {
		std::cout <<std::hex << std::showbase 
			<< "Destructor for : " << this->data << " {" << *this->data << "}" << std::endl;
		delete data;
	}
	else {
		std::cout << std::hex << std::showbase
			<< "[*] Destructor: "  << this->oldPtrAdd << "is now nullptr" << std::endl;

	}
}


/* Shallow Copy Constructor - no delegation
 * ex source.data = address0x123{5}
 * this->data will = address 0x123{5} too
 */
/*
Move::Move(const Move& source)
	//:data(source.data) 
{
	// recall: int *data; is a pointer 
	// this->data pointer = source.data pointer
	// pointer = address of source.data
	this->data = source.data;
  std::cout << "Shallow copy called << std::endl;
} 
*/


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
	std::cout << "Copy Constructor - Deep copy for new pointer: " << this->data << " {" << *source.data << "}" <<std::endl;
}


// Move constructor 

/*  So why is the Move constructor called instead of copy?
*   - because the inner brackets calls the default constructor which is an
*     r-value and its temporary value
	'noexcept' checks to make sure no exceptions are found during compiling

    Note how this is almost like a shallow copy, but we will null out the original pointer
    so that there is only 1 pointer pointing to data in heap */
/// @param &&source = Move{num} is an R-Value
Move::Move(Move &&source) noexcept 
	// :data(source.data) ctor initialization option 1
{
	this->data = source.data;	// assign data pointer to source.data pointer in memory
	std::cout << " Move from old pointer: " << &source.data <<" Constructor to new pointer: " << &this->data << " {" << std::dec<< *this->data << "}@" << this->data <<std::endl;
	source.data = nullptr;
}