## Deep/Shallow Copy constructors
================================================================================================
* A good thing to do is print the pointers out to see what is happening behind the scenes.
```c++
// Default constructor
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

```
================================================================================

### Shallow Ccopy Constructor (Bad, ends up with 2 pointers pointing to same data)

```c++
/* Shallow Copy Constructor - no delegation
 * ex source.data = address0x123{5}
 * this->data will = address 0x123{5} too
 */
Move::Move(const Move& source)
 :data(source.data) 
 {
	 //recall: int *data; is a pointer 
	 this->data pointer = source.data pointer
	 
	//pointer = address of source.data
	this->data = source.data;
  	std::cout << "Shallow copy called << std::endl;
}
```

### Deep copying 
* (Good, but expensive, 2 different pointers, 2 different data clones)
```cpp
/* DEEP Copy Constructor - delegate to constructor
 * See here we are creating a whole new pointer on the heap with data
 * and just storing the actual dereference value in that pointer
 * NOT copying the pointer like shallow
 */

# Deep copy
Move::Move(const Move& source)
	: Move(*source.data) - delegate to constructor  // Method 1
{
// Method 2 - not using the constructor
  this->data pointer =  *source.data pointer
	this->data = new int;

 new address = same value of source
	*this->data = *source.data;
	std::cout << "Copy Constructor - Deep copy for: " << *data << std::endl;
}
```

### Move constructor 
* ( similar to shallow copy, but delete the original pointer so new pointer only points to data - better efficiency)
```cpp
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
```
