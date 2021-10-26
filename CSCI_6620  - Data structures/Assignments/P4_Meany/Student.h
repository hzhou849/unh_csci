/*
 * Student.h
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P4 Meany
 * Name:        HOWARD ZHOU - ID# 00748064
 */


#ifndef _STUDENT_H
#define _STUDENT_H
#pragma once


#include <string>
class Student
{

	friend class CList;
public:
	Student(std::string pFname, std::string pLname) :
		fName(pFname), lName(pLname), seen(false) {}

private:
	bool seen;
	std::string fName;
	std::string lName;
	
};

#endif // _STUDENT_H

