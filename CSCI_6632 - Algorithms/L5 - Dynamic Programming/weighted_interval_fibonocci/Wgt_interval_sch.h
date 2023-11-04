#pragma once
// Dynamic Programming Algorithm
// See L5 slides for timing interval
//
// Algorithm for interval scheduling with weight
// 0	1	2	3	4	5	6	7	8	9
// [2;100-----------]               [9;30]
//				[4,25---]		[8,50----]
//			[3,90---]	[7,80-------]
// [1,80--------]	[6,70]
// Recusive algorithm for optimum solution is: 
// opt[i] = max { opt[i-1], v_i + opt[p_i] }
// pi = largest previous jobs j such last j.finishTime <= i.startTime
// i is the next job with time after j.finishTime

#include <iostream>
#include <array>


typedef struct Jb 
{
	int jNum;
	int st_time;
	int fin_time;
	int weight;

}jobs;

typedef struct optNode
{
	int num;
	int vi;
	optNode* optn;
	int total;
	int st_time;
	int fin_time;
	int weight;
	bool bi;

}optData;

class WIntSched
{

static constexpr int SIZE=10;
int m_pi=0;


public:
	WIntSched()
	{
		// Initialize node
		/*for (int i= 0; i<opt.size(); i++)
		{
			opt[i]->num = i;
			opt[i]->vi = 0;
			opt[i]->optn = nullptr;
			opt[i]->total = 0;
		}*/

		// Create the jobs
		optNode j0 ={ 0, 0, &j0, 0, 0, 0, 0,false };
		optNode j1 ={ 1, 0, &j0, 0, 0, 3, 80,false };
		optNode j2 ={ 2, 0, nullptr, 0, 0, 4, 100,false };
		optNode j3 ={ 3, 0, nullptr, 0, 2, 4, 90,false };
		optNode j4 ={ 4, 0, nullptr, 0, 3, 5, 25, false };
		optNode j5 ={ 5, 0, nullptr, 0, 4, 6, 50, false };
		optNode j6 ={ 6, 0, nullptr, 0, 4, 7, 70, false };
		optNode j7 ={ 7, 0, nullptr, 0, 5, 8, 80, false };
		optNode j8 ={ 8, 0, nullptr, 0, 7, 9, 50, false };
		optNode j9 ={ 9, 0, nullptr, 0, 8, 9, 30, false };

		opt[0] = &j0;
		opt[1] = &j1;
		opt[2] = &j2;
		opt[3] = &j3;
		opt[4] = &j4;
		opt[5] = &j5;
		opt[6] = &j6;
		opt[7] = &j7;
		opt[8] = &j8;
		opt[9] = &j9;

		printList(opt);

		optSolution();
	}


private: 

	std::array<Jb*, SIZE> list;  // the initial list
	std::array<optNode*, SIZE> opt;   // The sorted optimum solution list

	void printList(std::array<optNode*, SIZE> arr)
	{
		for (int i=0; i< arr.size(); i++)
		{
			std::cout << "Job[" << i << "]: st: " << arr[i]->st_time <<"; ft: " << arr[i]->fin_time << "; Weight: " << arr[i]->weight << std::endl;
		}
	}


	optNode* max(optNode* t1, int vi,  optNode* t2, int current_i)
	{
		//if (t1->weight )
		//int t1_total = t1->vi + t1->weight;
		std::cout << "vi: " << vi << std::endl;
		int t1_total = t1->total;
		int t2_total = vi + t2->total;

		


		if (t1_total > t2_total)
		{
			opt[current_i]->vi = 0;
			opt[current_i]->total =  t1->total;
			std::cout << "node: [" << t1->num << "]; total: " << t1->total << std::endl;
			std::cout << "optnode: [" << t2->num << "]; total: " << t2->total << std::endl;
			std::cout << "current_node1[" << current_i << "]; total " << opt[current_i]->total << std::endl;
			return t1;
		}
		else
		{
			// This is a new optimal solution
			opt[current_i]->bi = true;  // used later to find optimal scheduling search
			opt[current_i]->vi = vi;
			opt[current_i]->total = vi + t2->total;
			std::cout << "node: [" << t1->num << "]; total: " << t1->total << std::endl;
			std::cout << "optnode: [" << t2->num << "]; total: " << t2->total << std::endl;
			std::cout << "current_node2[" << current_i << "]; total " << opt[current_i]->total << std::endl;
			return t2;
		}

	}

	void optSolution()
	{
		int total = 0;
		int maxNode = 0;
		optNode* oNode;
		

		for (int i=1; i<list.size(); i++)
		{
			std::cout << "\n------------------opt[" << i << "] -----------------------------" << std:: endl;
			opt[i]->optn = max(opt[i-1], opt[i]->weight, getPi(opt[i]), i );

			
		}
	}

	// Search for the hightest pi = previous node with prevJob.finishTime <= currJob_start
	optNode* getPi(optNode*  ni)
	{
		int currNode = ni->num;
		int counter = currNode-1;
		int a_fin;
		int b_start;

		while (counter > 0 &&  opt[counter]->fin_time > opt[currNode]->st_time)
		{
			a_fin = opt[counter]->fin_time;
			b_start = opt[currNode]->st_time;


			--counter;
		}

		optNode* oNode = opt[counter]->optn;
		int opt_total = opt[counter]->vi + oNode->vi + oNode->weight;
		std::cout << "Pi found: opt[" << counter << "]" << std::endl;

		ni->optn = opt[counter];
		return opt[counter];
	}


};


