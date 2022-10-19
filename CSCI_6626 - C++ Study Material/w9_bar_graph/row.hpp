/*
 * Week 9 - Interacting classes 
 * Program: Bar graph				File: row.hpp
 * 
 * @brief: Class for a linked-list row and its cells
 */

#pragma once
#include "item.hpp"
#include "tools.hpp"

/* Dependant class. Holds an Item and a link to another cell*/
class Cell {
friend class Row; // Grants access to Row's private members
private:
	Item info;
	Cell* next;

	Cell (char* name, int sc, Cell* next) 


};