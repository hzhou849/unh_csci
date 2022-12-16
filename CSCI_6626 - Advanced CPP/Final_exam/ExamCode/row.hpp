// Final exam question, Fall 2022								   	     row.hpp
#pragma once
#include "exam.hpp"
//==============================================================================
class Row {
protected:
    int     score[nexams];

public:
    Row()  = default;
    ~Row() = default;
    ostream& print(ostream& out);
    istream& read(istream& in);

};
inline ostream& operator<<(ostream& out, Row& r ){ return r.print(out); }
inline istream& operator>>(istream& in, Row& r ) { return r.read(in);}

