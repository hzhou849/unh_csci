/* Shallow Copy Constructor - no delegation
 * ex source.data = address0x123{5}
 * this->data will = address 0x123{5} too
 */
Move::Move(const Move& source)
 :data(source.data) 
 {
	 recall: int *data; is a pointer 
	 this->data pointer = source.data pointer
	 pointer = address of source.data
	this->data = source.data;
  std::cout << "Shallow copy called << std::endl;
}


/* DEEP Copy Constructor - delegate to constructor
 * See here we are creating a whole new pointer on the heap with data
 * and just storing the actual dereference value in that pointer
 * NOT copying the pointer like shallow
 */

# Deep copy
Move::Move(const Move& source)
	: Move(*source.data) - delegate to constructor
{
  this->data pointer =  *source.data pointer
	this->data = new int;

 new address = same value of source
	*this->data = *source.data;
	std::cout << "Copy Constructor - Deep copy for: " << *data << std::endl;
}
