//-----------------------------------------------------------------------------
// File:         bad.hpp
//
// Brief:        Exception Classes for Sudoku board
//
// Project/ver:  P7 - Exception
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------
#pragma once
#include  "tools.hpp"

class Bad {
public: 
    char chVal;
    string str;

    Bad (char val) : chVal(val) {};  // make this a string val and jsut pass string(char*) to it
    virtual ~Bad()=default;
    virtual void print() {
        cout << "Base super bad" << endl;
    }
    
    void commonPr() {
        cout << "Common print: bad value: " << chVal << endl;
    }

};

class BadDerA: public Bad {
public:
    BadDerA (char val) : Bad(val) {}
    virtual ~BadDerA() {}
    virtual void print() {
        cout << "Bad Derived A print called. " << endl;
        commonPr();
    }
};

class BadDerB: public Bad {
public:
    BadDerB (char val) : Bad(val) {}
    virtual ~BadDerB() {}
    virtual void print() {
        cout << "Bad Derived B print called. " << endl;
        commonPr();
    }
};

class BadDerS: public Bad {
public:
    string str;
    BadDerS (string str) :  Bad('x'), str(str){}
    virtual ~BadDerS() {}
    virtual void print() {
        cout << "Bad Derived S print called. [" << str << endl;
        commonPr();
        
    }
    
};
