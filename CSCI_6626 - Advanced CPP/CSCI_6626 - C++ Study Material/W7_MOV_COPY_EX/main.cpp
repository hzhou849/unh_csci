/* Week 7 - Moving objects code from professor  
 * stupid code doesn't work. Those macros are broken
*/


#include <iostream>
#include <vector>
//#include <ostream>

using namespace std;
/* Macro to print and tehn run a line of source code*/
#define v(a) std::cout << "\n["#a"]" << std::endl; //\a

/* Macro to print a variable */
#define p(a) #a"=" << a

// Class Test
class Test {
private:
    int x;
    int* arr = new int[3];

public:
    // Default Null constructor
    Test() : x(0), arr(nullptr) {
        std::cout << " Null constructor" << std::endl;
    }

    // Explicit Constructor
    explicit Test(int x) : x(x) {
        std::cout << "Explicit constructor Test( " << x << " )" << std::endl;
    }

    ~Test() {
        delete[] arr;
        std::cout << "\t[*] Test() destructor called" << std::endl;
    }

    /* COPY Constructor */
    Test(const Test& source)    // x(source.x), arr(source.arr)
    {
        x = source.x;
        arr = source.arr;
        std::cout << "[+] Copy constructor called" << std::endl;
    }

    /* Move constructor */
    Test(Test&& source) // x(source.x), arr(source.arr)
    {
        this->x = source.x; // stack item, not pointer we don't need to delete
        this->arr = source.arr;

        // source.arr = nullptr;
        // Or we can do this which is safer
         if (this != &source) source.arr = nullptr;
         
         //std::cout << "[+] Move constructor called" << std::endl;
         std::cout << "[+] Move = assignment from x:" << &source.x << " to " << &x << " [" << x << "]" << std::endl;
         std::cout << "[+] Move = assignment from arr:" << &source.arr << " to " << &arr << " [" << arr << "]" << std::endl;

    }

    /* Copy Assignment */
    Test& operator=(const Test& source) {
        this->x = source.x;
        this->arr = source.arr;
        std::cout << "[+] Copy assignment = " << std::endl;
        return *this;
    }

    /* Move Assignment */
    Test& operator=(Test&& source) {
        if (this != &source) {
            x = source.x;

            delete[] arr; // purge the data in here first
            std::cout << "[+] Move = assignment from x:" << &source.x << " to " << &x << " [" << x <<"]" <<std::endl;
            std::cout << "[+] Move = assignment from arr:" << &source.arr << " to " << &arr <<  " [" << arr << "]" << std::endl;
            arr = source.arr;
            source.arr = nullptr;
        } 
        return *this;
    }

    std::ostream& print(std::ostream& os) const {
        return os << "(" << x << "; " << arr << ")";
   }
};

inline std::ostream& operator<< (std::ostream& os, Test& tObj) {
    return tObj.print(os);
}

int main(void)
{
 /*   v(Test b(17);)
        std::cout << "" << std::endl;
    v(Test a; )
        std::cout << " " << p( a) << std::endl;*/
    Test obj1;
    Test obj2(obj1);

    std::vector<Test> obj3;
    obj3.push_back( Test(10) );
    obj3.push_back( Test(20) );
    obj3.push_back( Test(30) );


    std::cout << "Normal termination" << std::endl;
    return 0;
}