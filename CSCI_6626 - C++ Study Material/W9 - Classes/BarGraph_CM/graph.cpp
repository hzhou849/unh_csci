/*
 * Week 9 - Interacting classes
 * Program: Bar graph				File: graph.cpp
 *
 * @brief: implementation of graph class
 */

#include "graph.hpp"

Graph::Graph (istream& infile) {
	char initials[4];			// Used locally for input
	int score;					// Used locally for input

	for (;;) {
		infile >> ws;			// skip leading whitespace before get
		infile.get(initials, 4, ' ');  // read exactly 3 intials. ;<buffer><count><delim>
		if ( infile.eof() ) break;
		infile >> score;
		if (infile.fail()) {
			infile.clear();
			cleanline(infile);
		}
		else insert (initials, score);  // can be infinite loop w/o the if
	}
}

/// @brief Insert a node into a Row
void Graph::insert(char* initials, int score) {
	int index;
	if (score >=0 && score < 100) {
		index = (score /(BARS -1));		// belongs in one of the  first BARS-1 rows
	}
	else {
		index = BARS-1;
	}
	bar[index].insert(initials, score); // delegation
}

/// @brief print the entire bar graph
ostream& Graph::print(ostream& os) const{
	os << "\n";
	for (int k=0; k<BARS; ++k) {
		os << bar[k] << endl;
	}
	return os;
}