/* CH8_redef_base_class.cpp :
 *
 * Inheritance CH8 - Redefining base class.
 * Example to show how to use base class members and functions
 * in a derived class without need to re-write functions.
 */

#include <iostream>
using namespace std;


/* Base Class*/
class Base {

	static const string def_nameStr; // More overhead, more features, less compatible.
protected:
	static constexpr const char* def_name = "unamed Account";     // less footprint, wider compatibility to convert 
	static constexpr  int num = 2; // More overhead, more features, less compatible.

	int balance;

public:
	Base() :Base(0) {}	// Delegating default ctor to overloaded one below with 0
	Base(int pData) : balance(pData) {}
	//~Base();  use the default destructor

	void deposit(int amount) { balance += amount; }
	void withdraw(int amount);
	
	// do not do endl; or you will have double /n if you add it to your printout too
	ostream& print(ostream& os) const { return os << balance; }   
};

inline ostream& operator<<(ostream& os, const Base bObj) { return bObj.print(os);  }


const string  Base::def_nameStr = "unamed account";

void Base::withdraw(int amount) {
	if (balance >= amount) {
		balance -= amount;
		cout << "[+] Base withdraw: -" << amount << "; new balance: " << balance;
	}
}

/* Derivived class*/
class Derived: public Base {
private:
	// We introduce this new variable in the derived class, for new features 
	// the base class does not have. 
	// We use this data to manipulate the base class data for demonstration
	int derData;

public:
	Derived() : Base(0), derData(0) {}			// Default null constructor via deligation for base members
	Derived(int baseVal, int pData) :Base(baseVal), derData(pData) {}
	//~Derived(); 

	void deposit(int amount) { balance += (amount * derData); }		// redefined function
	void withdraw(int amount);		// redefined function

	// Although we can use the base print, derived data will be sliced bc
	// they do not exist in the base class
	// Redefined only because we need to print data specific to derData
	ostream& print(ostream& os) const { return os << balance << "; " << derData; }
};

inline ostream& operator<< (ostream& os, Derived dObj) { return dObj.print(os); }

void Derived::withdraw(int amount) {

}

int main()
{
	cout << "Hello CMake." << endl;
	cout << "-- Base class stuff --" << endl;

	Base b1;
	b1.deposit(100);
	cout << "Base amount: " << b1 << endl;

	Derived d1(100, 5);
	d1.deposit(100);
	cout << "Derived amount: " << d1 << endl;

	return 0;
}
