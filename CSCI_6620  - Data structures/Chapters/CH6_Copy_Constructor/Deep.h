#pragma once
#include <iostream>

// Deep copy - creates new storage and copy values
class Deep
{
public:
	Deep(int d);
	~Deep();

	// Copy Constructor
	Deep(const Deep &source);


	void set_data_value(int d) { *data = d; }
	int get_data_value() { return *data; }


private:
	int *data;

};


// Constructor
Deep::Deep(int d)
{
	data = new int; // Allocate memory in heap 
	*data = d;
}


// Destructor
Deep::~Deep()
{
	delete data;
	std::cout << "Destructor freeeing data" << std::endl;
}

// DEEP Copy Constructor
Deep::Deep(const Deep &source)
	: Deep{*source.data}  // delegate constructor 
{
	std::cout << "Copy constructor - Deep copy" << std::endl;
}

