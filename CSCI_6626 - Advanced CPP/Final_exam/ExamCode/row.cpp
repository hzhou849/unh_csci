// Final exam question, Fall 2022								   	     row.cpp
//==============================================================================
#include "row.hpp"
//------------------------------------------------------
ostream& Row:: print( ostream& out ) {
	for (int k=0; k<nexams; ++k)  out <<setw(6) << score[k] ;
	return out;
}

//------------------------------------------------------
// Writes the scores from file into the array
istream& Row:: read (istream& in ) {
	for (int i=0; i < nexams; ++i) in >> score[i];
	return in;
}
