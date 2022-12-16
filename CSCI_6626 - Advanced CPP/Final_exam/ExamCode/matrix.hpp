// Final exam question, Fall 2022								   	  matrix.hpp
#pragma once
#include <algorithm>
#include "exam.hpp"
#include "student.hpp"
//==============================================================================
class Matrix {
  private:
    vector<StuData*> students;
    int    score[nexams] = {0};
    float  average[nexams];
    float  getAverage( int i ) { return students[i]->getAverage(); }

  public:
    Matrix(istream& fin);
    ~Matrix(){ cerr <<"Grade summary is in exams.out\n\n"; }
    void      vertTotals();
	  void      sortStu();
	  ostream&  print( ostream& out );
};
