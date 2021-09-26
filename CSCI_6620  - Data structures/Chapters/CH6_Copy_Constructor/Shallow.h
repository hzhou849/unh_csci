#pragma once

#include <iostream>
class Shallow
{
public:
	// Constructor
	Shallow(int d);
	~Shallow();

	// Copy Constructor
	Shallow(const Shallow &source);
	


	void set_data_value(int d);
	int get_data_value();


private:
	int *data;

};

Shallow::Shallow(int d)
{
	data = new int; // allocate memory on heap and return address to be stored in data.
	*data = d;
}

Shallow::Shallow(const Shallow &source)
	: data(source.data)
{
	std::cout << "Copy constructor - Shallow copy" << std::endl;
}

void Shallow::set_data_value(int d) { *data = d; }

int Shallow::get_data_value()
{
	return *data;
}

Shallow::~Shallow()
{
	delete data;
	std::cout << "Destructor freeing data" << std::endl;
}

