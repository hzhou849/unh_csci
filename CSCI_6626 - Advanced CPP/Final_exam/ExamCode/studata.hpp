// Final exam, Fall 2022							   	     studata.hpp
#pragma once
#include <iostream>
#include "row.hpp"
//======================================================================
class StuData : private Row {
	int total = 0;
	float average;	
	string fName, lName;
	//Row::score[4] inherited access
	
public:
	StuData (istream& fin);
    virtual	~StuData() =default;
    virtual	ostream& print(ostream& out);
	int    getScore(int k) const { return score[k]; }
	float  getAverage()    const { return average; }
    static bool myfunction(StuData* a, StuData* b) {
		std::cout << "A: " << a->average << "B: " << b->average <<endl;
		return a->average > b->average; 
	}
};

inline ostream& operator<< (ostream& out, StuData* s){ return s->print(out); }

