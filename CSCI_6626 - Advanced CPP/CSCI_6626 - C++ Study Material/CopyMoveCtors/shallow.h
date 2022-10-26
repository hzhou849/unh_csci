// Shallow class to demonstrate shallow copies

#pragma once
#include <iostream>

class Shallow {
private:
	int *data;
public:
	// Constructor
	Shallow(int d);

	// Copy Constructor
	Shallow(const Shallow &source);

	// Destructor
	~Shallow();

	//Set/getters
	void setData(int d) { *data = d; }
	int  getData() { return *data; }
};
	void dipsplay_shallow(Shallow sObj) {}


// Implementation
//=====================================================================================

Shallow::Shallow(int d) {
	data = new int;
	*data = d;
}

Shallow::Shallow(const Shallow &source)
	: data(source.data) {
	std::cout << "Copy constructor called - SHALLOW COPY" << std::endl;
}

Shallow::~Shallow() {
	delete data;
	std::cout << "Destructor freeing data" << std::endl;
}

// Bc this is pass-by-value, the copy constructor will be called 
// This will result in a shallow copy
void displayShallow(Shallow sObj) {
	std::cout << sObj.getData() << std::endl;
}

