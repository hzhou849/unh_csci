// L5 - Matrix_chain_multi.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <memory>
#include "pass2dArr.h"


typedef struct mTable
{
    int tableNum;
    int row;
    int column;
    

};
// Global variables to help track values easier in debugger

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


mTable A1 ={ 1, 3, 2 };
mTable A2 ={ 2, 2, 4 };
mTable A3 ={ 3, 4, 2 };
mTable A4 ={ 4, 2, 5 };

static const int d0 = A1.row;
static const int d1 = A2.row;
static const int d2 = A3.row;
static const int d3 = A4.row;
static const int d4 = A4.column;

int dTable[5] ={ d0, d1, d2, d3, d4 };


/* 2 Dimenstional array table for results */
// 0-4 created 1 extra dimension so we can use 1-index for storing results
// Row [0] will not be used for simplicity
//optData (*tPtr)[5] = new optData[5][5];
optData result_table[5][5] ={ {} };


//typedef struct optData
//{
//    int cost;
//    int k;
//};



void printTable(optData (&table)[5][5] )
{
    int tempK;

    std::cout << "testing2: "<<table[1][1].cost << "; " << table[1][1].k << std::endl;
    std::string fill = " ";
    for (int i=1; i<=4; i++)
    {
        if (i==1)
        {
            std::cout << " " << i << " " << i+1 <<" " << i+2 << " " << i+3 << std::endl;
        }


        for (int j=1; j<=4; j++)
        {
            if (j < i) // print blank cells
            {

                std::cout <<i<<","<< j<< "=[" <<std::setw(3)<< fill << "   ]  "; 
            } 
            else
            {
                std::cout <<i<<","<< j<< "=[" <<std::setw(3)<< table[i][j].cost << ", " << table[i][j].k << "]  ";
                //std::cout <<i<<","<< j<< ") [" <<std::setw(3)<< table[i][j]->cost << ", " << table[i][j].k << "]  ";
            }
          
        }
        std::cout << std::endl;
    }
}


void matrix_chain(optData (&table)[5][5] )
{
    int j;
 
    for (int l=2; l<5; l++)
    {
        // for i <- 1 to (n-l+1)
        for (int i=1; i<= ( (5-l) +1); i++)
        {
            j = (i + l -1);
            table[i][j].cost = 999999; // a large number for the first round
            for (int k=i; k < j; k++) // i<=k < j
            {
                if (table[i][k].cost + table[k+1][j].cost + (dTable[i-1]*dTable[k]*dTable[j]) < table[i][j].cost)
                {
                    // Do this to protect writting out of array bounds
                    if (j < 5)
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
    for (int i=1; i<=4; i++)
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
