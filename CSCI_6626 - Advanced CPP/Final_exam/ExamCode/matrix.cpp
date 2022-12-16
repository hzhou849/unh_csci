// Final exam question, Fall 2022								 matrix.cpp
//=========================================================================
#include "matrix.hpp"
#include "iostream"
//-------------------------------------------------------------------------
Matrix::Matrix(istream& fin) {
	char code;
	// For loop for each line of the exams.in U <Name> <G1> <G2> <G3> <G4>
    for(;;) {
        fin >> code;
        if (fin.eof()) break;

        if (code=='G') students.push_back(new GStudent(fin));  // Grad vector
        else           students.push_back(new UGStudent(fin)); // UG vector
	}
	vertTotals();
}

//-------------------------------------------------------------------------
void Matrix::
vertTotals() {
	int ex;  			  					    // for double loop
	for (ex=0; ex<nexams; ++ex) {
        for ( StuData* st: students )  {
			score[ex] += st->getScore(ex);
		}
        average[ex] = (float)score[ex] / students.size();   // Class average on exam j.
	}
}

//------------------------------------------------------------------------
ostream& Matrix:: print(ostream& out) {
	out << "------------------------------\n";
    for ( StuData* st: students ) st->print(out); // gots to st.print()
	out << "------------------------------\n";
	out <<setprecision(1)  <<right <<fixed <<" ";  
	for (int ex=0; ex<nexams; ++ex )  out <<setw(6) << average[ex];   
	out <<" : Class average for each exam\n------------------------------\n";
	return out;
}
		
//------------------------------------------------------------------------
void Matrix:: sortStu() {
    // sort(students.begin(), students.end(), StuData::myfunction);
    sort(students.begin(), students.end(), [](StuData* a, StuData* b) {return a->getAverage() > b->getAverage();});

}
