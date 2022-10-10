/* Shallow vs Deep Copy constructors */

#include <iostream>
#include "shallow.hpp"
#include "deep.hpp"

int main(int argc, char* argv[]) {
    // Shallow sObj(100);
    // display_shallow(sObj);

    // // Bad! becuase now sObj which has invalid data
    // // is  copied again into sObj2
    // Shallow sObj2(sObj);

    // // Now we are accidentally changing sObj and sObj2 to 1000;
    // // bad unless this is intentional
    // sObj2.setDataValue(1000); 

    // std::cout << sObj2.getDataValue() << std::endl;


    Deep dobj1 (99);
    display_deep(dobj1);

    Deep dobj2 (dobj1);
    dobj2.setDataValue(888);

    std::cout << dobj1.getDataValue() << "; "<< dobj2.getDataValue() << std::endl;

    

}