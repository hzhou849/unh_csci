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
class Move
{
private:
	int *data;

public:
	Move(int d);
	~Move();

	// Copy Constructor
	Move(const Move& source);    // - L-Value

	// Move Constructor
	//Move(Move &&source) noexcept;

	void setVal(int d) { *data = d; }
	int getVal() { return *data;  }

};


Move::Move(int d = 0) {
	// Create a new pointer on the heap
	// and dereference and store int d
	data = new int; 
	*data = d;
	std::cout << "Constructor for : " << this->data <<" {" << d << "}" << std::endl;
}

Move::~Move() {
	std::cout << "Destructor for : " << this->data << " {" << *this->data << "}" << std::endl;
	delete data;
}


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
	std::cout << "Copy Constructor - Deep copy for new pointer: " << this->data << " {" << *source.data << "}" <<std::endl;
}
