// L5 - Matrix_chain_multi.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <memory>
#include "pass2dArr.h"

static const int TABLE_SIZE = 6;

typedef struct mTable
{
    int tableNum;
    int row;
    int column;
    

};
// Global variables to help track values easier in debugger


/* This example TABLE_SIZE = 5 */
    /* Create the tables from lecture */
   /* mTable A1 = {1, 3, 5 };
    mTable A2 = {2, 5, 2 };
    mTable A3 = {3, 2, 6 };
    mTable A4 = {4, 6, 9 };
    mTable A5 = {5, 9, 4 };*/


/* Tables from notes 
 *    A1      A2      A3      A4
 *  [3  2]  [2  4]  [4  2]  [2  5]
 *   |  |____|  |____|  |____|  |
 *  d0    d1      d2       d3   d4
 */

//// Default test set
//mTable A1 ={ 1, 3, 2 };
//mTable A2 ={ 2, 2, 4 };
//mTable A3 ={ 3, 4, 2 };
//mTable A4 ={ 4, 2, 5 };
//
//static const int d0 = A1.row;
//static const int d1 = A2.row;
//static const int d2 = A3.row;
//static const int d3 = A4.row;
//static const int d4 = A4.column; // right number is column
//
//int dTable[TABLE_SIZE] ={ d0, d1, d2, d3, d4 };



/* Calculation 2 
 *
 *    A1      A2         A3      A4      A5
 * [3   4]  [4  10]   [10  6]  [6  8]  [8  7]
 *  |   |____|   |_____|   |____|  |____|  |
 * d0     d1        d2       d3      d4    d5
 *
 */
// Table num, row, column
mTable A1 ={ 1, 3, 4 };
mTable A2 ={ 2, 4, 10 };
mTable A3 ={ 3, 10, 6 };
mTable A4 ={ 4, 6, 8 };
mTable A5 ={ 5, 8, 7 };

static const int d0 = A1.row;
static const int d1 = A2.row;
static const int d2 = A3.row;
static const int d3 = A4.row;
static const int d4 = A5.row;
static const int d5 = A5.column;

int dTable[TABLE_SIZE] ={ d0, d1, d2, d3, d4, d5 };

/* 2 Dimenstional array table for results */
// 0-4 created 1 extra dimension so we can use 1-index for storing results
// Row [0] will not be used for simplicity
//optData (*tPtr)[5] = new optData[5][5];
optData result_table[TABLE_SIZE][TABLE_SIZE] ={ {} };


//typedef struct optData
//{
//    int cost;
//    int k;
//};



void printTable(optData (&table)[TABLE_SIZE][TABLE_SIZE] )
{
    int tempK;

    std::cout << "testing2: "<<table[1][1].cost << "; " << table[1][1].k << std::endl;
    std::string fill = " ";
    for (int i=1; i<=(TABLE_SIZE-1); i++)
    {
        if (i==1)
        {
            std::cout << " " << i << " " << i+1 <<" " << i+2 << " " << i+3  << "" << i+4 << std::endl;
        }


        for (int j=1; j<=(TABLE_SIZE -1); j++)
        {
            if (j < i) // print blank cells
            {

                std::cout <<i<<","<< j<< "=[" <<std::setw(3)<< fill << "   ]  "; 
            } 
            else
            {
                std::cout <<i<<","<< j<< "=[" <<std::setw(3)<< table[i][j].cost << ", " << table[i][j].k << "]  ";
            }
          
        }
        std::cout << std::endl;
    }
}


void matrix_chain(optData (&table)[TABLE_SIZE][TABLE_SIZE] )
{
    int j;
 
    for (int l=2; l<TABLE_SIZE; l++)
    {
        // for i <- 1 to (n-l+1)
        for (int i=1; i<= ( (TABLE_SIZE-l) +1); i++)
        {
            j = (i + l -1);
            table[i][j].cost = 999999; // a large number for the first round
            for (int k=i; k < j; k++) // i<=k < j
            {
                if (table[i][k].cost + table[k+1][j].cost + (dTable[i-1]*dTable[k]*dTable[j]) < table[i][j].cost)
                {
                    // Do this to protect writting out of array bounds
                    if (j < TABLE_SIZE)
                    {
                        table[i][j].cost = table[i][k].cost + table[k+1][j].cost + (dTable[i-1]*dTable[k]*dTable[j]);
                        table[i][j].k = k;
                    }
                }
            }
        }

        

    }
}

int main()
{
    
    


    //for (int i=0; i<5; i++)
    //{
    //    for (int j=0; j<5; j++)
    //    {
    //        result_table[i][j].cost = i; 
    //        result_table[i][j].k = j; 
    //    }
    //}

    std::cout << "testing: "<< result_table[1][1].cost << "; " << result_table[1][1].k << std::endl;

    // insert the known [i,i] = 0 values in the table
    for (int i=1; i<=(TABLE_SIZE -1 ); i++)
    {
        result_table[i][i].cost = 0;
        result_table[i][i].k = 0;
    }
    

    printTable( result_table);

    matrix_chain(result_table);

    printTable(result_table);


}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
