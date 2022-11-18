//-----------------------------------------------------------------------------
// File:         myExcept.hpp
//
// Brief:        Exception Classes for Game logic related errors
//
// Project/ver:  P7 - Exception
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------


/* errors: 
//     main.cpp
//     1)  80 - if (argc <2) = fatal()
//     2) 85 - if (!inputFile.good()) = fatal()

//     game.cpp
//     1) 28 if (!validate (gameType_m)) = fatal() 
    
//     board.cpp
//     1) 146 getPUzzle(): if char invalid = fatal(error invalid char in file)

//     State.cpp
//     1) commented!!! 24 - fatal(undefined character entered) *** might not needed anymore
//     2) 37 - (invalid input character passed to mark)

// state.cpp:36:        fatal( "Invalid input character passed!"); 
// game.cpp:29:        fatal("\n[!] Fatal Error - Game TYPEChar from file is not a legal character!");
//OK! board.cpp:146:                    fatal("[!] ERROR - invald character in file: ");
//OK! board.cpp:154:                fatal("[!] Low-level error while reading input stream.");
//OK! SudokuMain-Zhou.cpp:78:    if (argc < 2) fatal("Usage:  main <input filename>\n"); 
//OK! SudokuMain-Zhou.cpp:82:    if ( !inputFile.good() ) fatal("[!] ERROR - Unable to open file! " +string(argv[1]) + "\n");


*/
#pragma once
#include "tools.hpp"

class GmError {
public:
    string errMsg;
    GmError(string err) : errMsg(err) {};
    virtual ~GmError()=default;
    virtual void print() { cout << "Game logic error detected..." << endl; }
    void basePr() { cout << "Error caught: \n" << "  " << errMsg << endl; }
};

class GmBadGameType : public GmError {
public:
    string err;
    GmBadGameType(string str) : GmError(str), err(str) {};
    virtual ~GmBadGameType() {};
    virtual void print() {
        cout << "[!] GmBadGameType() Exception thrown!\n"
             << "  Invalid type char detected - '" << endl;
        basePr();
    }
};

class GmBadInputChar : public GmError {
public:
    string err;
    GmBadInputChar(string str) : GmError(str), err(str) {};
    virtual ~GmBadInputChar() {};
    virtual void print() {
        cout << "[!] GameBadInputChar() Exception thrown!\n"
             << " Invalid number for Square used - " << endl;;
        basePr();
    }
};

class GmFatal: public GmError {
public: 
    GmFatal(string err) : GmError(err) {};
    virtual ~GmFatal() {};
    virtual void print() {
        cout << "[!] GameFatal() Exception thrown!" << endl;
        basePr();
        exit(1);
    }
};


//=============Stream Errors=====================================================================

class StreamErr {
public:
    string errMsg; 

    StreamErr(string err) : errMsg(err) {};
    virtual ~StreamErr()=default;
    virtual void print() {
        cout << "Stream type error detected..." << endl;
        basePr();
    }

    void basePr() {cout << "Error message: \n" << "  " << errMsg << endl; }
};

class StreamFatal : public StreamErr {
public:

    StreamFatal(string err) : StreamErr(err) {};
    virtual ~StreamFatal() {};
    virtual void print() {
        cout << "[!] StreamFatal() Exception thrown!" << endl;
        basePr();
        exit(1);
    }
};

// class Bad {
// public: 
//     string errStr;

//     Bad (string msg) : errStr(msg) {};  // make this a string val and jsut pass string(char*) to it
//     virtual ~Bad()=default;
//     virtual void print() {
//         cout << "Base super bad: " << endl;
//     }
    
//     void commonPr() {
//         cout << "Common print: bad value: " << errStr << endl;
//     }

// };

// class BadDerA: public Bad {
// public:
//     BadDerA (char val) : Bad(string(1, val) ) {}
//     virtual ~BadDerA() {}
//     virtual void print() {
//         cout << "Bad Derived A print called. " << endl;
//         commonPr();
//     }
// };

// class BadDerB: public Bad {
// public:
//     BadDerB (char val) : Bad(val) {}
//     virtual ~BadDerB() {}
//     virtual void print() {
//         cout << "Bad Derived B print called. " << endl;
//         commonPr();
//     }
// };

// class BadDerS: public Bad {
// public:
//     string str;
//     BadDerS (string str) :  Bad('x'), str(str){}
//     virtual ~BadDerS() {}
//     virtual void print() {
//         cout << "Bad Derived S print called. [" << str << endl;
//         commonPr();
        
//     }
    
// };
