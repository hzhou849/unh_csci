#pragma once
#include "frame.hpp"
#include "tools.hpp"

template <typename T>
class Stack : private vector<T> {
private:
    vector<T> vStack_m;

public:
     Stack() {};
     ~Stack() {};

    Frame* top() { return vStack_m.back();}
    void pop() { vStack_m.pop_back(); }
    void push( Frame* inFrm ) { vStack_m.push_back(inFrm); }
    int size() { return vStack_m.vector<T>::size(); }
    void zap() { for (int itr = vStack_m.vector<T>::size(); itr-- >0; ) 
                    { cout << "Popping: " << itr << endl;vStack_m.pop_back(); }   }
    Frame* at (int index) {return vStack_m.vector<T>::at(index); }
};


