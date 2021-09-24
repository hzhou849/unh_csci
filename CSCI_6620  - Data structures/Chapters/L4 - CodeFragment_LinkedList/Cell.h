#pragma once

#include <string>

#ifndef _CELL_H
#define _CELL_H


// Struct declaration
typedef std::string BT;		// Private structures go in cpp file. Public in header

class Cell
{
public:
	// Simple class defined here for simplicity
	// Cell *nx default is assigned as nullptr if not specified 
	Cell(BT dt, Cell *nx = nullptr): data(dt), next(nx) {}
	~Cell() {}

	//Cell::Cell(BT dt, Cell *nx = nullptr) : data(dt), next(nx) {};


private:

	// A friend class can access private and protected members of other class in which 
	// it is declared as friend. 
	friend class SList;		// friend grants privileges allow SList class to access private members of Cell
	BT data;
	Cell *next;


};

#endif //_CELL_H