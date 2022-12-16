#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include "tools.hpp"


// U Johnny Johnson, 83 45 64 50 
void print( istream& fin) {
    string fname; // Johnny
    string lname; // Johnson
    int score[4];
    int total;
    int average;

    fin >> fname;
    getline(fin, lname, ',');
    cout << "fname: " << fname << "lname: " << lname; 

    for (int k=0; k<4; ++k ) {
        fin >> score[k]; 
        cout << "; " << score[k];
        total +=score[k];
    }
    average = (float)total / 4;
    cout  <<" total: " << total << " average:" << average<< endl;


}


int main (int argc, char* argv[]) {
    std::ifstream fin(argv[1]);
    std::ofstream fout ("exams.out");

    char code;
    for (;;) {
        fin >> code; //code 'G' read here
        if (fin.eof()) break;
        
        if (code == 'G') {
            print( fin);
        } else {
            print (fin);
        }

    }   
}