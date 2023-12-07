// CSCI 6632 - Algorithms
// Howard Zhou
//
/// LCS Class with textfile diffing, working!
// Special symbols, Null 0xC1, h_line = 0xC4, \ = 0x5C
// '|' = 0x7C
//  Row = Source file
// Col = Destination file

#pragma once
#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
static constexpr char leftArr = 0xC4;
static constexpr char nullSet = 0xC1;
static constexpr char upArr = 0x7C;
static constexpr char diagArr = 0x5C;

typedef struct optNode
{
	int val=0;
	char ch = ' ';
};

class Lcs {
public:
	Lcs(std::ifstream & txtSrc, size_t sSize,  std::ifstream& txtDes, size_t dSize);
	~Lcs();
	void lcsDiff(optNode* opt);

private:
	void retrieveLCS(optNode* table);
	void printTable(optNode* table);
	void initTable(optNode* table);
	size_t cell(int row, int col);
	
	size_t m_sizeAs;
	size_t m_sizeBd;
	
	size_t m_tableSize;
	std::ifstream& m_fileSrc;
	std::ifstream& m_fileDes;
	char m_A[256];
	char m_B[256];
	optNode *opt;
	size_t m_TABLE_ROW;
	size_t m_TABLE_COL;

};


Lcs::Lcs(std::ifstream & txtSrc, size_t sSize, std::ifstream& txtDes, size_t dSize)
	: m_fileSrc(txtSrc), m_sizeAs(sSize), m_fileDes(txtDes), m_sizeBd(dSize),
	m_TABLE_ROW(sSize+1), m_TABLE_COL(dSize+1) 
{
	m_tableSize = (m_TABLE_ROW * m_TABLE_COL)+1; // extra cell needed for table math +1
	std::cout << "\n LCS CLass: " << std::endl;
	opt = (optNode*)malloc ((m_tableSize) * sizeof(optNode));
	initTable(opt);
	lcsDiff(opt);
}

Lcs::~Lcs() { delete[] opt; }

size_t Lcs::cell(int row, int col) {
	return (row*(m_TABLE_ROW-1) + (col));
}

void Lcs::initTable(optNode* table) {
	for (int i=0; i< m_tableSize; i++) {
		opt[i].ch = ' ';
		opt[i].val = 0;
	}
}


void Lcs::retrieveLCS(optNode *table) {
	char dList[256]={'\x0'};
	char aList[256]={'\x0'};
	char S[256] ={ ' ' };
	char tempChar;
	int i= m_TABLE_ROW -1; // A n
	int j = m_TABLE_COL -1; // B m 
	int strSize = m_TABLE_COL + m_TABLE_ROW;

	while (i>=0 && j>=0) {
		tempChar = table[cell(i, j)].ch;
		if (j==0 && static_cast<std::uint32_t>(table[cell(i,j)].ch) <= '\x20' || 
			j==0 && static_cast<std::uint32_t>(table[cell(i, j)].ch) >= '\x7E') {
			dList[i] = m_A[i-1];
			--j;
		}
		else if (table[cell(i,j)].ch == '\\') {
			S[i] = m_A[i-1];
			--i;
			--j;
		}
		else if (table[cell(i,j)].ch == '|') {
			dList[i] = m_A[i-1];

			--i;
		}
		else { // '-' or '0xC4
			if (j-1 >0)
				aList[j] = m_B[j-1];
			--j;
		}

	}

	// Print original string
	std::cout << "Source Text file: \n" << m_A << std::endl;
	std::cout << "\nModified Text file: \n" << m_B << std::endl;

	// Print deleted
	std::cout << "\n Deleted: " << std::endl;
	for (size_t i=0; i< strSize; i++)
	{
		std::cout << dList[i] << " ";
	}
	std::cout << std::endl;
	// Print result:
	std::cout << "\n Results: " << std::endl;
	for (size_t i=0; i <strSize; i++)
	{
		std::cout <<S[i] <<" ";
	}
	std::cout << std::endl;


	// Print added
	std::cout << "\n Added: " << std::endl;
	for (size_t i=0; i< strSize; i++)
	{
		std::cout << aList[i] << " ";
	}
	std::cout << std::endl;

	std::cout << "\n combined: "  << std::endl;
	for (size_t i=0; i< strSize; i++)
	{
		if (static_cast<uint32_t>(dList[i]) != '\x0')
			std::cout <<"[-"<< dList[i] << "] ";
		if (static_cast<uint32_t>(aList[i]) != '\x0')
			std::cout <<"[+"<< aList[i] << "] ";
		std::cout << S[i] << " ";
	}
	std::cout << "\n" << std::endl;
}

void Lcs::printTable(optNode* table)
{
	int wPadding = 8;
	char tempChar;
	// Print x-axis header
	std::cout << "  ";
	for (size_t i=0; i< m_TABLE_COL; i++) {
		if (i==0)
			std::cout << std::setw(7) << i;
		else
			std::cout << std::setw(wPadding) << i;
	}
	std::cout << std::endl;
	std::cout << "  ";
	for (size_t i=0; i < m_TABLE_COL; i++)
	{
		tempChar = m_B[i];
		if (i==0)
			std::cout << std::setw(7) << '~';
		else
			if (tempChar=='\n')
				tempChar='\\';

			std::cout << std::setw(wPadding) << tempChar;
		
	}
	std::cout << std::endl;
	for (size_t i=0; i<m_TABLE_ROW; i++)
	{
		for (size_t j=0; j<m_TABLE_COL; j++)
		{
			if (j==0)
			{
				std::cout <<" ";
				if (m_A[i] == 0x0) {
					m_A[i] = '*';
					std::cout   <<m_A[i]<< " "<<std::setw(2) << i << " [" <<std::setw(3) <<table[cell(i, j)].val <<", " <<std::setw(1)<<table[cell(i, j)].ch <<  "] ";
				}
				else
				{
					tempChar = m_A[i-1];
					if (tempChar == '\n')
						std::cout <<std::setw(1)<<"\\" << " "<<std::setw(2)<< i << " [" <<std::setw(3) <<table[cell(i,j)].val <<", " <<std::setw(1)<<table[cell(i,j)].ch <<  "] ";
					else if (i==0) {
						tempChar ='~';
						std::cout <<std::setw(1)<<tempChar<< " "<<std::setw(2)<< i << " [" <<std::setw(3) <<table[cell(i,j)].val <<", " <<std::setw(1)<<table[cell(i,j)].ch <<  "] ";
					}
					else 
						std::cout <<std::setw(1)<<tempChar<< " "<<std::setw(2)<< i << " [" <<std::setw(3) <<table[cell(i,j)].val <<", " <<std::setw(1)<<table[cell(i,j)].ch <<  "] ";
				}
			}
			else {
				std::cout <<  "[" <<std::setw(2) <<table[cell(i,j)].val <<", " <<std::setw(1)<<table[cell(i,j)].ch <<  "] ";
			}
		}
		std::cout << std::endl;
	}
	std::cout <<"\n" << std::endl;
}




// Text Diff one line at a time
void Lcs::lcsDiff(optNode* opt) {
	m_fileSrc.read(m_A, m_TABLE_ROW);
	m_fileDes.read(m_B, m_TABLE_COL);

	printTable(opt);

	// Start Algorithm
	// Initial first row of B to all zero j/B/Col
	for (int j=0; j< m_TABLE_COL; j++) {
 		opt[cell(0,j)].val = 0;
		opt[cell(0, j)].ch = nullSet;
	}

	for (int i=1; i<m_TABLE_ROW; i++) {
		opt[cell(i, 0)].val = 0;
		opt[cell(i, 0)].ch = nullSet;

		for (int j=1; j<m_TABLE_COL; j++)
		{
			/*std::cout << "\nA["<<i <<"]: " <<m_A[i-1]<< "; B[" <<j <<"]: " << m_B[j-1] << std::endl;
			std::cout << "cell: " << i << "; " << j << std::endl;*/
			if (m_A[i-1] == m_B[j-1]) {
				opt[cell(i,j)].val = (opt[cell(i-1, j-1)].val) + 1;
				opt[cell(i,j)].ch = '\\'; // 0x5C
			}
			else if (opt[cell(i,j-1)].val >= opt[cell(i-1,j)].val) {
				opt[cell(i,j)].val = opt[cell(i,j-1)].val;            // value of previous colum
				opt[cell(i,j)].ch = opt[cell(i,j)].ch = leftArr;
			}
			else {
				opt[cell(i,j)].val = opt[cell(i-1,j)].val;     // val from one row up
				opt[cell(i,j)].ch = '|';
			}
		}
	}
	printTable(opt);
	retrieveLCS(opt);
}


