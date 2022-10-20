// BaseDerived_test.cpp : Defines the entry point for the application.
//

#include "BaseDerived_test.h"

using namespace std;

// 
class Base {
private:
	int value;
	
public:

	Base() : value{ 0 } {
		cout << "Base default constructor called." << endl;
	}

	~Base() { cout << "Base destructor" << endl; }

	Base(int x) :value{ x } {
		cout << "Base - overload INT called" << endl;
	}

	// Copy constructor
	Base(const Base& source) 
		:value (source.value)
	{
		// Essentially we are doing
		//this->value = source.value;
		cout << "[+] Base Copy constructor" << endl;
	}

	// Base Operator= overload
	// call.operator=( arg ) is the call
	Base& operator=(const Base &rhs) {
		cout << "[+] Base Operator=" << endl;
		if (this == &rhs) { return *this;  }

		value = rhs.value;
		return *this;
	}

};

class Derived :public Base {

private:
	int doubled_value;

public:	
	Derived() :
		Base{} {cout << "Derived default ctor called."; }

	Derived(int x)
		// Call the copy constructor from base
		: Base(x), doubled_value(x * 2) {
		cout << "Derivied overload constructor" << endl;
	}

	Derived(const Derived & other)
		: Base(other), doubled_value(other.doubled_value) {
		cout << "[+] Derived Copy constructor called." << endl;
	}

	Derived& operator=(const Derived &rhs) {
		cout << "[+] Derived operator=" << endl;
		if (this == &rhs) { return *this; }

		// Call the base case overload= function
		Base::operator=(rhs);
		doubled_value = rhs.doubled_value;
		return *this;
	}
};


int main()
{
	Base b(100);		// Overloaded ctor test
	Base b1(b);			// Copy constructor test
	b = b1;				// Copy assignment

	Derived d(100);		// Overloaded ctor test
	Derived d1(d);		// Copy constructor test
	d = d1;				// Copy assignment
	return 0;
}
