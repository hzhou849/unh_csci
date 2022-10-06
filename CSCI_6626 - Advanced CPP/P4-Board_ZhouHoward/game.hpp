//----------------------------------------------------------------------------- 
// File:        game.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project:     P3 - Square
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Due Date:    09-20-2022
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

/* 
* Dr Fischer -  @tags is not Java. This is called DOXYGEN, its an industry standard 
* and modern IDEs recognize this to tag class objects, parameters, objects and it is 
* very helpful. Please feel free to ignore it but if it bothers you that much as
* I can remove it on the submitted version so you can read easier.
*/ 

#pragma once
#include "tools.hpp"
#include "board.hpp"

// Labels & Names - revised tools.cpp changed from char* to string
static const string GAME_TITLE = "Sudoku Game";
static const string MENU_OPTIONS = "murseq";

// /// @brief Class Board - Forware declaration for P3
// //-----------------------------------------------------------------------------
// class Board;

// game is going to 'new' the board 

/// @brief Class Game
//-----------------------------------------------------------------------------
class Game {
private:

  // Member Variables
  static const string menuList[6];
  static const string legalCodes;

  ifstream& inFile_m;
  int  gameSize_m;    // Only accepted values are 6 and 9; ** remove for p4
  char gameType_m;    // Accepted values are: 
                      // 't' - traditional 
                      // 'd' - diagonal
                      // 's' - sixy



  // Member Functions
  bool validate(char readChar);
  Board* board_m; //

public:
  Game()=default;
  Game(ifstream& inputFile);
  ~Game();
  void run();

};