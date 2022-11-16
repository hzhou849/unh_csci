/* except.cpp
 *
 * Test polymorphic exceptions
 *
 */

#include <iostream>
#include <exception>


/// @brief MyException - Base Class
class MyExceptionBase
{
public:
    virtual void raise() { throw *this; }
};



/// @brief ExceptionLogger
class MyExDerived : public MyExceptionBase {
public:
    virtual void  raise() { throw *this;}
};

void fTest1(MyExceptionBase & ex) {
    ex.raise();
}


int main() {
    MyExDerived ex;

    try {
        fTest1(ex);
    }

    catch (MyExDerived& ex) {
        std::cout << "Catch derivied" << std::endl;
    }
}


