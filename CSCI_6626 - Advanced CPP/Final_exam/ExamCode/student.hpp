// Final exam question, Fall 2022								   	 student.hpp
#pragma once
#include "studata.hpp"
//==============================================================================
class GStudent : public StuData {
  public:
	GStudent(istream& fin) : StuData(fin) {}
  ~GStudent(){cerr << "-G";}
  
  //-----------------------------------
  virtual ostream& print(ostream& out) { 
    out << "Grad: "; 
    return StuData::print(out);
  }
};

//==============================================================================
class UGStudent : public StuData  {
  public:
    UGStudent(istream& fin) : StuData(fin) {}
    ~UGStudent(){cerr << "-UG";}
    
    //------------------------------------
    virtual ostream& print(ostream& out) { 
        out << "UG:   "; 
        return StuData::print(out); 
    }
};
