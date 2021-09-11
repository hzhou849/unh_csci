// CSCI_6620_-CH3_UNORDERED_LIST.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include "UnsortedType.h"
#include "ItemType.h"

#include "SortedType.h"

//0100 1101 -4D  M  B
//01              \
//1101 01 - 65    e
//01 1010 - 32    2
//01      -01     \
//0111 0010 - 72  r

/// <summary>
///  Creates and test the unsorted list class
/// </summary>
void UnsortedList()
{
    std::cout << std::boolalpha;
    //std::cout << std::noboolalpha;

    ItemType item1(1);
    ItemType item2(2);
    ItemType item3(3);

    //ItemType::RelationshipType Rtype;


    switch (item1.ComparedTo(item2))
    {
    case ItemType::LESS:
        std::cout << "ITEM1 is LESS";
        break;
    case ItemType::GREATER:
        std::cout << "ITEM1 is GREATER!";
        break;
    case ItemType::EQUAL:
        std::cout << "Item1 is EQUAL";
        break;
    }

    std::cout << std::endl;


    UnsortedType utest;
    utest.putItem(item1);
    utest.putItem(item2);
    utest.putItem(item3);

    utest.printList();

    ItemType test(0);
    bool foundTest = false;


    test = utest.GetItem(item3, foundTest);

    std::cout << "Item retrieved: " << test.getValue() << " status: " << foundTest << std::endl;
}

/// <summary>
/// Creats and tests the Sorted list class.
/// </summary>
void SortedList()
{
    ItemType item1(1);
    ItemType item2(2);
    ItemType item3(3);
    ItemType item4(4);
    ItemType item5(5);

    // Create the Sorted List object
    SortedType *sortedTest = new SortedType;

    sortedTest->PutItem(item5);
    sortedTest->PutItem(item2);
    sortedTest->PutItem(item3);
    sortedTest->PutItem(item1);
    sortedTest->PutItem(item4);

    sortedTest->PrintList();



    delete sortedTest;

}

int main()
{
   
    //UnsortedList();
    SortedList();


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
