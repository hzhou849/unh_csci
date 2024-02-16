// Longest commmon subsequece algorithm with chars list 
// Simplified version for short char array DEMO
// Special symbols: 
// Nullset =  0xC1
// '-' = 0xC4, 
// '\' = 0x5C
// '|' = 0x7C
//

#pragma once
#include <iostream>
#include <iomanip>
#include <cstring>
namespace LCSChar
{


static constexpr int TABLE_SIZE_ROW = 8; // A n
static constexpr int TABLE_SIZE_COL = 7; // B m
static constexpr char leftArr = 0xC4;
static constexpr char nullSet = 0xC1;
static constexpr char upArr = 0x7C;
static constexpr char diagArr = 0x5C;

static constexpr char A[8] = "bacdcak";
static constexpr char B[7] = "adbcda";


typedef struct optData
{
    int val=0;   // should be optaddr[i,j] + 1
    char ch=' ';
    //char ch=nullSet; 
    //optNode *optAddr;
};

void retrieveLCS(optData (&table)[TABLE_SIZE_ROW][TABLE_SIZE_COL])
{
    int i  = TABLE_SIZE_ROW -1;  // A n
    int j =  TABLE_SIZE_COL - 1; // B m
    char tempChar;

    char A[8] = "bacdcak";
    char B[7] = "adbcda";
    char S[10] ={' '};
    char dList[10] = {'\x0'};
    char aList[10] = {'\x0'};

    while (i >= 0 && j>= 0) {
        std::cout << "current i: " << i << "; j: " << j << "- " <<std::hex<<std::showbase<< static_cast<uint32_t>(table[i][j].ch) << std::endl;
        tempChar = table[i][j].ch;
        if (j==0 && static_cast<std::uint32_t>(table[i][j].ch) <= '\x20') {
            std::cout << "null found! " << std::endl;
            dList[i] = A[i-1];
            --j;
        }
        else if (table[i][j].ch == '\\') {
            S[i] = A[i-1];
            --i;
            --j;
        }
        else if (table[i][j].ch == '|') {
            dList[i] = A[i-1];

            --i;
        }
        else { // '-' or '0xC4
            if (j-1 >0)
                aList[j] = B[j-1];
            --j;
        }
        
    }

    // Print deleted
    std::cout << "\n Deleted: " << std::endl;
    for (size_t i=0; i< 10; i++)
    {
        std::cout << dList[i] << " ";
    }
    std::cout << std::endl;
    // Print result:
    std::cout << "Results: " << std::endl;
    for (size_t i=0; i <10; i++)
    {
        std::cout <<S[i] <<" ";
    }
    std::cout << std::endl;


    // Print added
    std::cout << "\n Added: " << std::endl;
    for (size_t i=0; i< 10; i++)
    {
        std::cout << aList[i] << " ";
    }
    std::cout << std::endl;

    std::cout << "\n combined: "  << std::endl;
    for (size_t i=0; i< 10; i++)
    {
        if (static_cast<uint32_t>(aList[i]) != '\x0')
            std::cout <<"[+"<< aList[i] << "] ";
        if (static_cast<uint32_t>(dList[i]) != '\x0')
            std::cout <<"[-"<< dList[i] << "] ";
        std::cout << S[i] << " ";
    }
}

void printArray(optData(&table)[TABLE_SIZE_ROW][TABLE_SIZE_COL])
{
    int wPadding = 9;
    char A[8] = "bacdcak";
    char B[7] = "adbcda";

    // Print x-axis header
    for (size_t i=0; i< TABLE_SIZE_COL; i++) {
        if (i==0)
            std::cout << std::setw(8) << i ;
        else
            std::cout << std::setw(wPadding) << i;
    }
    std::cout << std::endl;
    for (size_t i=0; i< TABLE_SIZE_COL; i++)
    {
        if (i==0)
            std::cout << std::setw(8) << B[i-1];
        else
            std::cout << std::setw(wPadding) << B[i-1];
    }
    std::cout << std::endl;

    for (size_t i=0; i<TABLE_SIZE_ROW; i++)
    {
        for (size_t j=0; j<TABLE_SIZE_COL; j++)
        {
            if (j==0)
            {
                if (A[i] == 0x0){
                    A[i] = 'X';
                }
                std::cout << " " <<A[i-1]<< " "<< i << " [" <<std::setw(3) <<table[i][j].val <<", " <<std::setw(1)<<table[i][j].ch <<  "] ";
            }
            else 
                std::cout <<  "[" <<std::setw(2) <<table[i][j].val <<", " <<std::setw(1)<<table[i][j].ch <<  "] ";
        }

        std::cout << std::endl;
    }
}


void lcs()
{
    int m =7;
    int n = 8;
    char A[8] = "bacdcak";
    char B[7] = "adbcda";

    optData opt[8][7];
    for (int i=0; i < 7; i++) {
        std::cout << "A[" << i << "]: " << A[i] << std::endl;
    }
    printArray(opt);
    
    // Start algorithm
    // initialize the first row of B to all zero 
    for (int j=0; j< m; j++) {
        opt[0][j].val = 0;
    }

    for (int i=1; i<n; i++) {
        opt[i, 0]->val = 0;

        for (int j=1; j<m; j++)
        {
            std::cout << "\nA["<<i <<"]: " <<A[i-1]<< "; B[" <<i <<"]: " << B[j-1] << std::endl;
            std::cout << "cell: " << i << "; " << j << std::endl;
            if (A[i-1] == B[j-1]) {
                opt[i][j].val = (opt[i-1][j-1].val) + 1;
                opt[i][j].ch = '\\'; // 0x5C
            }
            else if (opt[i][j-1].val >= opt[i-1][j].val) {
                opt[i][j].val = opt[i][j-1].val;            // value of previous colum
                opt[i][j].ch = opt[i][j].ch = leftArr;
            }
            else
            {
                opt[i][j].val = opt[i-1][j].val;     // val from one row up
                opt[i][j].ch = '|';
            }
            

        }
    }

    printArray(opt);
    retrieveLCS(opt);
}
}