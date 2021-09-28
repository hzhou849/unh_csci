/*
 * Filename: p3_little_dog_part1.cpp

 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 1
 * HOWARD ZHOU  - ID# 00748064
 *
 * 
 * - Implement a main function with a command-line argument that does these things:
 * - Call banner() at the beginning of your program and bye() at the
 * - Instantiate the List class
 * - Open and read in the file named by the command-line argument. Handle eof properly.  If there are any problems, call fatal)().
 * - The input file contains a series of lines of text. Do not modify my file in order to make your program work. Do not remove the newline character on the end of the last line.
 * - Use List::insert() to insert each line of the file into the List. (This is a linked-list insertion sort.)
 * - Call bye() before you return from
 * 
 * 
 */
#include <iostream>
#include "List.h"


int main()
{
	List myList;

	// Call banner()

	myList.LoadLinkedListNOTSorted();

	// bye() 
}

