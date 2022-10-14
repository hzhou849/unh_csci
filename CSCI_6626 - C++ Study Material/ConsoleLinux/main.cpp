#include <iostream>

class Move {
    int *data;
public:
    Tester();
    ~Tester();
    int getVal();

};

/* Implementation */

Tester::Tester() {
    data = new int;
    *data = d;
}

Tester::~Tester() { delete data; }

int* Tester::getVal() { return *data; }

int main()
{
    Tester tObj;
    std::cout << "Tester: " << tObj.getVal() << std::endl;
    return 0;

}