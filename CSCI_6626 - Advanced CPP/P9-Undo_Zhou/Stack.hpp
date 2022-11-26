#pragma once
#include "frame.hpp"
#include "tools.hpp"


template <typename T>
class Stack : private vector<T> {
private:



public:
    Stack() {};
    ~Stack() {};
 inline   void pop() { std::vector::pop_back(); }

};


