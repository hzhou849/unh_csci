/*
 * Week 9 - Interacting classes - demo classes
 * Program: Bar graph				File: BarGraph_CM.cpp
 *
 * @brief: Read scores from a user file and display them as a bar graph
 * 
 * To compile in VS set flag "use_CRT_SERCURE_NO_WARNINGS"
 * Method 1: use strcopy_s
 * or method2: set flag to supress warnings
 * goto: Configuration Properties >> C/C++ >> preprocessor >> preprocessor defintions
 *       double click and add this flag
 * 
 * Conceptiual Diagram:
 * Graph object
 * Row bar[11]
 * [Row_0]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_1]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_2]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_3]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_4]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_5]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_6]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_7]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_8]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_9]  ={cell linked list -> name1 -> name2 -> name_N}
 * [Row_10] ={cell linked list -> name1 -> name2 -> name_N}
 */

#include <iostream>
#include "tools.hpp"
#include "graph.hpp"
using namespace std;

int main()
{
	Graph::instructions();
	string fname;
	cout << "Name of the data file: ";
	//cin >> fname;
	//ifstream infile (fname);
	ifstream infile ("bar.txt");

	if (!infile.is_open ()) { fatal ("Can't open"+ string(fname.data()) +"for input.\n"); }

	cout << "File is open and ready to read" << endl;
	Graph curve (infile);			// Declare and construct a Graph object.
									// Realize data structure from a file
	cout << curve;					// Storage belonging to curve will be freed when main exits
	return 0;
}
/* Output:
 ----------------------------------------------------------------
 Alice Fischer
 Exploring C++ : Chapter 9
 Sat Jul 23 2022    14:31:45
 ----------------------------------------------------------------
 Put input files in same directory as the executable code.
 Name of data file: bar.txt
 File is open and ready to read.

 00..09:  AWF 0
 10..19:
 20..29:
 30..39:  PLK 37
 40..49:
 50..59:  ABA 56
 60..69:  PRD 68   RBW 69
 70..79:  HST 79   PDB 71   FDR 75
 80..89:  AEF 89   ABC 82   GLD 89
 90..99:  GBS 92   MJF 98
 Errors:  ALA 105   JBK -1

 Normal termination.
 ~Graph
 ~Row Errors:   ~Cell  ~Item ALA  ~Cell  ~Item JBK  End
 ~Row 90..99:   ~Cell  ~Item GBS  ~Cell  ~Item MJF  End
 ~Row 80..89:   ~Cell  ~Item AEF  ~Cell  ~Item ABC  ~Cell  ~Item GLD  End
 ~Row 70..79:   ~Cell  ~Item HST  ~Cell  ~Item PDB  ~Cell  ~Item FDR  End
 ~Row 60..69:   ~Cell  ~Item PRD  ~Cell  ~Item RBW  End
 ~Row 50..59:   ~Cell  ~Item ABA  End
 ~Row 40..49:   End
 ~Row 30..39:   ~Cell  ~Item PLK  End
 ~Row 20..29:   End
 ~Row 10..19:   End
 ~Row 00..09:   ~Cell  ~Item AWF  End
 */
