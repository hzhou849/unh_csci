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

// Menu Names
static const char* MENU_LIST[6] = { "Mark", 
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


/// @brief Class Board
//-----------------------------------------------------------------------------
class Board;

class Game {
private:

  // Member Variables
  ifstream inputFile_m;
  Board* board_m;
  int  gameSize_m;    // Only accepted values are 6 and 9;
  char gameType_m;    // Accepted values are: 
                      // 't' - traditional 
                      // 'd' - diagonal
                      // 's' - sixy


  // Member Functions
  bool validate(const char& readChar);
  void run();

public:
  Game(const string& fileName);
  ~Game() =default;

};