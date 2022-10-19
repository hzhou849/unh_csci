/*
 * Week 9 - Interacting classes
 * Program: Bar graph				File: graph.hpp
 *
 * @brief: Declaration for bargraph
 */

#pragma once
#include <istream>
#include "tools.hpp"
#include "row.hpp"

#define BARS 11

class Graph {

private:
	Row bar[BARS];						// Each list is one bar of the graph (composition)
	void insert(char* name, int score);

public:
	/*static functions are called without a class instance*/
	static void instructions () {
		cout << "Put input files in same directory as exec code" << endl;
	}

	Graph ( istream& infile );
	~Graph () { cout << "[*] Graph Destructor called." << endl; }

	ostream& print (ostream& out) const;		             // Param is an open input stream

};

inline ostream& operator<<(ostream& os, const Graph& gObj) {
	return gObj.print (os);
}