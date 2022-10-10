/* Deep copy 
 *
 * unlike shallow copy which creates a new object and just
 * creates a new pointer pointing to the same destination of source,
 * Deep copying creates a new pointer pointing to a different location
 * with a copy of the data. 
 */

#include <iostream>

class Deep {
private:
    int *data;

public:
     void setDataValue(int d) { *data = d; }
    int getDataValue() { return *data; }

    // Constructor
    Deep(int d);

    // DEEP Copy Constructor
    Deep (const Deep& source);

    // Destructor
    ~Deep();

};

Deep::Deep (int d) {
    data = new int;
    *data = d;
}


// vs shallow copy which is:
// : data(source.data) assigns the this->data_pointer = source data_pointer
    // this->data = source.data;

// See the difference, shallow just assignes the data  whereas
// deep will create a new copy of pointer and data by delegating to constructor
Deep::Deep(const Deep& source) 
    : Deep(*source.data) { // *Delegate to constructor

    // Basically creating a new data object  with duplicate data too.

    //Deep (*source.data);
    // bascailly creating a whole new object with Deep (same number);
    // which will create an entirely new instance of data - a full copy of original
    // with different memory location on the heap

}

Deep::~Deep() {
    delete data;
    std::cout << "Deep destructor called" << std::endl;
}

/* now a new object with a new set of pointers will be created 
 * and deleted after out of scope, but since they unlike shallow copy, they point
 * to different locations on the heap it can get deleted and not interefere
 * with the source pointers
 */
void display_deep(Deep dObj) {

    std::cout << dObj.getDataValue() << std::endl;
}