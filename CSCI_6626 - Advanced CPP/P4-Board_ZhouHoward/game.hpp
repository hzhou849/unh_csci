//----------------------------------------------------------------------------- 
// File:        game.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project:     P3 - Square
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

/* 
* Dr Fischer -  @tags is not Java. This is called DOXYGEN, its an industry standard 
* and modern IDEs recognize this to tag class objects, parameters, objects and it is 
* and is handy for various features. Please ignore it.
*/ 

#pragma once
#include "tools.hpp"
#include "board.hpp"

// Forware declaration for P3
// class Board;


/// @brief Class Game
//-----------------------------------------------------------------------------
class Game {
private:

  // Member Variables
  static const string menuList[6];
  static const string legalCodes;

  ifstream& inFile_m;
  char gameType_m;    // Accepted values: (t)raditional,(d)iagonal, (s)ixy

  // Member Functions
  bool validate(char readChar);
  Board* board_m;

public:
  Game()=default;
  Game(ifstream& inputFile);
  ~Game();
  void run();

};