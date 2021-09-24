// CH6_Copy_Constructor.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
// CSCI 6620 - Data Structures
// Lecture week 4 - Chapter 6 Text Book
/*
 *
 *   Copy Constructor - SHALLOW COPY Example
 * 
 *  - When copying objects compiler will default memberwise copy.
 *  - Beware if you have a pointer data member, Pointer will be copied,
 *     NOT what it is pointing too (Shallow Copy).
 *   
 *  Best Practices:
 *  - Provide a copy constructor when your class has raw pointers.
 *  - Provide a copy constructor with const and pass-by-reference parameter (either & or *pointer)
 *  - use STL classes as they already provide copy constructors
 *  - Avoid using raw pointer data members if possible and use smart pointers.
 */

#include <iostream>

class Player
{
public:
    std::string get_name() { return name; }
    int get_health() { return health; }
    int get_xp() { return xp; }

    Player(std::string name_val = "None", int health_val = 0, int xp_val = 0);

    // Copy Constructor
    Player(const Player &source);
    
    // Destructor
    ~Player() { std::cout << "Destructor called for: " << name << std::endl; }

private:
    std::string name;
    int health;
    int xp;
};


// Implementation

Player::Player(std::string name_val, int health_val, int xp_val)
    :name{ name_val }, health{ health_val }, xp{ xp_val }
{
    std::cout << "Three-args constructor for " + name << std::endl;
}

// Copy Constructor Implementation 
Player::Player(const Player &source)
    : name{source.name}, health{source.health}, xp{ source.xp }
{
    std::cout << "Copy Constructor - made a copy of : " << source.name << std::endl;
}


void display_player(Player p) 
{
    std::cout << "Name: "   << p.get_name() << std::endl;
    std::cout << "Health: " << p.get_health() << std::endl;
    std::cout << "XP: "     << p.get_xp() << std::endl;
}


int main()
{
    Player empty;
    
    display_player(empty);
    Player frank { "Frank" }; 
    Player hero  { "Hero", 100 };
    Player villain { "Villain", 100, 55 };

    return 0;
    
    std::cout << "Hello World!\n";
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
