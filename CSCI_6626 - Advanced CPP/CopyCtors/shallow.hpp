/* Demonstrate shallow copy */

#include <iostream>
#include <string>

class Shallow {

private:
    int *data;

public: 
    void setDataValue(int d) { *data = d; }
    int getDataValue() { return *data; }

    // Constructor
    Shallow(int d) ;

    // Copy Constructor
    Shallow (const Shallow& source);

    // Destructor
    ~Shallow();
};

Shallow::Shallow(int d) {
    
    data = new int;
    *data = d;
}

// Since source.data is a pointer - this->pointer = source pointer
Shallow::Shallow (const Shallow& source) 
    : data(source.data) {

    // equvaliant call ctr to body is:
    // this->data = source.data;

    std::cout << "Copy Constructor - Shallow copy: " << std::endl;
}

Shallow::~Shallow() {
    delete data;
    std::cout << "Destructor freeing data" << std::endl;
}


/* The memory leak occurs here bc we are doing pass-by-value, 
 * The copy constructor is called and bc we are only doing shallow copy,
 * a new pointer is create but it is pointer to the source object's data.
 * Shallow copy only creates a new pointer to point to the same data as source.
 * When this function goes out of scope and the destructor will be called on this 
 * new instance - thereby terminating the sObj.data <- which original object is pointing too
 * as well, rendering that data no good 
 * 
 * ex.
 *  origin pointer ->  address1 = data
 *  shallow pointer -> address1 = data too
 *  shallow pointer destructor is called, data is now marked for delete
 * when origin destructor is called, data is already deleted therefore crash
 * 
 * SOLUTION: DEEP-COPYING!!!
 * */

void display_shallow(Shallow sObj) {

    std::cout << sObj.getDataValue() << std::endl;
}

