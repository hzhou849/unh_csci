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

#pragma once
#include "tools.hpp"
#include "board.hpp"

// Labels & Names - revised tools.cpp changed from char* to string
static const string GAME_TITLE = "Sudoku Game";
static const string MENU_OPTIONS = "murseq";
static const string MENU_LIST[6] = { "Mark", 
                                    "Undo",
                                    "Redo",
                                    "Save Game",
                                    "Restore Game",
                                    "Quit"
                                  };

// Game codes
static const char GCODE_TRAD = 't';
static const char GCODE_DIAG = 'd';
static const char GCODE_SIXY = 's';
static const string LEGAL_CODES = "TtDdSs";


// /// @brief Class Board - Forware declaration for P3
// //-----------------------------------------------------------------------------
// class Board;

// game is going to 'new' the board 

/// @brief Class Game
//-----------------------------------------------------------------------------
class Game {
private:

  // Member Variables
  int  gameSize_m;    // Only accepted values are 6 and 9;
  char gameType_m;    // Accepted values are: 
                      // 't' - traditional 
                      // 'd' - diagonal
                      // 's' - sixy


  // Member Functions
  bool validate(const char& readChar);
  Board* board_m; //

public:
  Game(ifstream& inputFile);
  ~Game() =default;
  void run();

};