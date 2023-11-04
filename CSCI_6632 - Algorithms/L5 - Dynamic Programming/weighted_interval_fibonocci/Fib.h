#pragma once
#include <iostream>
#include <vector>
#include <memory>
#include <array>


class Fib {

static constexpr int SIZE = 20;

public:
	Fib(int n) 
	{
        fibSeq(n);

        // initialize the vector
        //   fill(vect1.begin(), vect1.end(), value);


	}
private: 
	//std::vector<int>* f;
	//std::unique_ptr<std::vector<int>> f; 
	//std::shared_ptr<std::vector<int>> f; 
     std::array<int, SIZE>  f = { 0 };


    //void printArray (std::vector<int>* vec)
    //void printArray (std::shared_ptr<std::vector<int>> vec)
    void printArray (std::array<int, SIZE> arr)
    {
        for (int i=0; i< arr.size(); i++)
        {
            std::cout << "f[" << i << "]: " << arr[i] << std::endl;
        }
    }

    void fibSeq(int n)
    {
        int temp = 0;

        f[0] = 0;
        f[1] = 1;

        for (int i = 2; i< n; i++)
        {
            f[i] = f[i-1] + f[i-2];
        }


        printArray(f);


    }

};