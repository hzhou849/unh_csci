// L5 - LongCommonSeq.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <typeinfo>
#include <complex>
//#include <bits/stdc++.h>
#include <algorithm>


typedef struct node
{
	int pos = 0;
	int value;
	int longest=0;
	int optMin=0;
	node *nextOptNode = nullptr;

};
static const int n = 11;

int A[11] ={ 30, 60, 20, 25, 75, 40, 10, 50, 90, 70, 80 };
//
//node A0 ={ 0, 30, 0, 0, nullptr };
//node A1 ={ 0, 60, 0, 0, nullptr };
//node A2 ={ 0, 20, 0, 0, nullptr };
//node A3 ={ 0, 25, 0, 0, nullptr };
//node A4 ={ 0, 75, 0, 0, nullptr };
//node A5 ={ 0, 40, 0, 0, nullptr };
//node A6 ={ 0, 10, 0, 0, nullptr };
//node A7 ={ 0, 50, 0, 0, nullptr };
//node A8 ={ 0, 90, 0, 0, nullptr };
//node A9 ={ 0, 70, 0, 0, nullptr };
//node A10 ={ 0, 80, 0, 0, nullptr };
//node nTable[11] ={ A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10 };



// Dynamic Programming C++ implementation
// of LIS problem


// lis() returns the length of the longest
// increasing subsequence in arr[] of size n
int lis(int arr[], int n)
{
	int lis[11] ={0};

	lis[0] = 1;

	// Compute optimized LIS values in
	// bottom up manner
	for (int i = 1; i < n; i++) {
		lis[i] = 1;
		for (int j = 0; j < i; j++)
			if (arr[i] > arr[j] && lis[i] < lis[j] + 1)
				lis[i] = lis[j] + 1;
	}

	// Return maximum value in lis[]
	return *std::max_element(lis, lis + n);
}

// Driver program to test above function
int main()
{
	//int arr[] ={ 10, 22, 9, 33, 21, 50, 41, 60 };
	int arr[] ={ 30, 60, 20, 25, 75, 40, 10, 50, 90, 70, 80 };
	int n = sizeof(arr) / sizeof(arr[0]);

	// Function call
	printf("Length of lis is %d\n", lis(arr, n));
	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

