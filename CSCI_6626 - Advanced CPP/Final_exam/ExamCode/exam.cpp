// Final exam question, Fall 2022								    exam.cpp
#include "exam.hpp"
#include "matrix.hpp"




//=========================================================================
int main( int argc, char* argv[] ) {
    if (argc!=2) fatal("usage: exam infile");
	ifstream fin(argv[1]);
    if (! fin) fatal( "Could not open "+string(argv[1]) );
    
	ofstream fout("exams.out");
	if (! fout) fatal( "Could not open exams.out." );	 

	cerr <<"Ready to read the input file.\n";
    cerr <<"\nThere are " <<nexams <<" exams.\n"; // nexams=4
	
	Matrix cs640(fin);

    cs640.print(cout);
    cerr << "------------------------------\n" <<"Beginning to sort "<< endl;
	cs640.sortStu();

	cs640.print(cout);								 
	cs640.print(fout);
	bye();				

	double (*expp) (double, double) = pow;
	expp(5.0, 2);
	cout << "expp: " << expp << "exp: " << exp(5.0) << endl;
}
