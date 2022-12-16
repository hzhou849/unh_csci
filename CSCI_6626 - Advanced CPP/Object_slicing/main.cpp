/* Demostrate object slicing C++*/

#include <iostream>
using namespace std;

/// @brief  Base class
class Base {
protected: 
    int bval;

public:
    Base(int a) { bval = a; }

    // Virtual function which is declared in base class class
    // and re-declared in derived class
    virtual void display() {
        std::cout << "I am Base class object i= " << bval << std::endl;
    }
};

/// @brief Derivied class
class Derived : public Base {
private:
    int dval;
    
public: 
    Derived(int bparam, int dparam) 
        : Base(bparam), dval(dparam) {}
    
    virtual void display() {
        std:: cout << "Derived class object: bval: " << bval << "dval: " << dval << std::endl;
    }
};

// Global function 
void globalDisplay(Base obj) { obj.display(); }

// Object slicing doesn’t occur when pointers or references to objects are passed as 
// function arguments since a pointer or reference of any type takes the same amount of memory.
void globalDisplay2( Base& obj ) { obj.display();} // pointers of references can prevent this

int main() {
    Base bobj(33);
    Derived dObj(11, 55);
    globalDisplay(bobj);

    // Object slicing, the member dval is sliced off
    globalDisplay(dObj);

    std::cout << "Using ref/pointer" << std::endl;
    globalDisplay2(dObj);

    return 0;

}