// Functions for the StuData class.    					         studata.cpp
#include "studata.hpp"
//=========================================================
StuData::StuData  (istream& fin){
	// parses the new student created and prints the current line?
	fin >> fName;
	getline(fin, lName, ',');
	for (int k=0; k<nexams; ++k ) {
		fin >> Row::score[k] ; 
		total += Row::score[k];
	}
	average = (float)total/nexams;
}

//------------------------------------------------------
ostream& StuData::print(ostream& out) {
	Row::print(out);
	out <<setprecision(1)  <<right <<fixed
	    << "    Total: " <<setw(5) << total<< "  Average:"
        <<setw(5) << average << "   ";
	return out << fName <<" " << lName <<"\n" ; // return everything above with these names
}
