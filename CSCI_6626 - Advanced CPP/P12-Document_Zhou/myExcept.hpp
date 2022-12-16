//-----------------------------------------------------------------------------
// File:         myExcept.hpp
//
// Brief:        Exception Classes Game logic & Stream related errors
//
// Project/ver:  P11 - Sixy
// Class:        CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:    Dr. Alice E. Fischer
// Name:         Howard Zhou
//-----------------------------------------------------------------------------

/* List of exceptions used:
 * state.cpp:36:        fatal( "Invalid input character passed!"); 
 * game.cpp:29:        fatal("\n[!] Fatal Error - Game TYPEChar from file is not a legal character!");
 * board.cpp:146:                    fatal("[!] ERROR - invald character in file: ");
 * board.cpp:154:                fatal("[!] Low-level error while reading input stream.");
 * SudokuMain-Zhou.cpp:78:    if (argc < 2) fatal("Usage:  main <input filename>\n"); 
 * SudokuMain-Zhou.cpp:82:    if ( !inputFile.good() ) fatal("[!] ERROR - Unable to open file! " +string(argv[1]) + "\n");
*/
#pragma once
#include "tools.hpp"

//-----------------------------------------------------------------------------
// Game logic related exceptions
//-----------------------------------------------------------------------------
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

class GmBadInputCell : public GmError {
public:
    string err;
    GmBadInputCell(string str) : GmError(str), err(str) {};
    virtual ~GmBadInputCell() {};
    virtual void print() {
        cout << "[!] GameBadInputCell() Exception thrown!\n"
             << " Invalid row/column data entered. - " << endl;;
        basePr();
    }
};

class GmFatal: public GmError {
public: 
    GmFatal(string err) : GmError(err) {};
    virtual ~GmFatal() {};
    virtual void print() {
        cout << "\n[!] GameFatal() Exception thrown!" << endl;
        basePr();
        exit(1);
    }
};

//-----------------------------------------------------------------------------
// Stream Type Exception 
//-----------------------------------------------------------------------------
class StreamErr {
public:
    string errMsg; 
    StreamErr(string err) : errMsg(err) {};
    virtual ~StreamErr()=default;
    virtual void print() {
        cout << "\n[!] Stream type error detected..." << endl;
        basePr();
    }
    void basePr() {cout << "Error message: \n" << "  " << errMsg << endl; }
};

class StreamFatal : public StreamErr {
public:
    StreamFatal(string err) : StreamErr(err) {};
    virtual ~StreamFatal() {};
    virtual void print() {
        cout << "\n[!] StreamFatal() Exception thrown!" << endl;
        basePr();
        exit(1);
    }
};
