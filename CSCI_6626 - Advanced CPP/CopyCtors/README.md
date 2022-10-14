## Deep/Shallow Copy constructors
* A good thing to do is print the pointers out to see what is happening behind the scenes.
```c++

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
