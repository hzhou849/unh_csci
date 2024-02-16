#pragma once
#include <iostream>

typedef struct optData
{
    int cost;
    int k;
};


//1 -  Pass by reference &
template <size_t rows, size_t cols>
void pass2dArr_ref(optData (&array)[rows][cols])
{
    std::cout << __func__ << "; " <<  array[1][1].cost  << std::endl;
}


/// 2 - Pass by pointer - does not print values correctly
void pass2d_arr_pointer (optData (*array)[5][5])
{
    std::cout << __func__ << "; " <<  array[1][1]->cost << std::endl;  // this will have bad data why??
    //std::cout << __func__ << "; " <<  (*array)[1][1].cost << std::endl; // this will work
}


//3 - Pass by value - not reccommended 
void pass2d_arr_value (optData (*array)[5], size_t rows)
{
    std::cout << __func__ << "; " <<  array[1][1].cost << std::endl;
}

// 4 - Pass by pointer to a pointer  - similar to int *array[x] 
void pass2d_arr_p2p(optData **array, size_t rows, size_t cols)
{
    std::cout << __func__ << "; " <<  array[1][1].cost << std::endl;
}


void pass2d_arr_pointer2 (optData **array[5])
{
    std::cout << __func__ << "; " <<  array[1][1]->cost<< std::endl;  // this will have bad data why??
    //std::cout << __func__ << "; " <<  (*array)[1][1].cost << std::endl; // this will work
}

void test()
{

    optData array[5][5] ={ {} };
      for (int i=0; i<5; i++)
      {
          for (int j=0; j<5; j++)
          {
              array[i][j].cost = i;
          }
      }
  
      // 1 - Pass by reference - probably the safest and without loosing the diemension information
      pass2dArr_ref(array);


      // 2 - Pass by pointer. notice the unusual usage of addressof (&) operator on an array
      // data got lost for some reason?
      pass2d_arr_pointer(&array);

      // 3 - pass by value, pointer to decayed type
      // works since arrays's first dimension decays into a pointer thereby becoming int (*)[5] instead of [5][5]
      pass2d_arr_value(array, 5);

      optData *surrogate_arr[5];
      for (size_t i=0; i < 5; ++i)
      {
          surrogate_arr[i] = array[i];
      }

      // another popular way to define b: here the 2D arrays dims may be non-const, runtime var
      // if trying to create array[5][10]:
      // int **b = new int*[5];
      // for (size_t i = 0; i < 5; ++i) b[i] = new int[10];

      pass2d_arr_p2p(surrogate_arr, 5, 5);
        // process_2d_array(b, 5);
      // doesn't work since b's first dimension decays into a pointer thereby becoming int**


      // Dynamic allocation
      //optData **testArry = (optData**)malloc (5 * sizeof(optData*));

      //for (size_t i=0; i<5; i++)
      //{
      //    testArry[i] = (optData*)malloc (5* sizeof(optData));
      //}
      //testArry[1][1].cost = 1;
      //pass2d_arr_pointer2(&testArry);
      // Note that arr[i][j] is same as *(*(arr+i)+j)

}