//----------------------------------------------------------------------------- 
// File:        game.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project/ver:  P9 - Undo
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"
#include "CanView/Viewer.hpp"

// Forware declaration for P3
class Board;

class Game {
private:
  // Member Variables
  static const string menuList[6];
  static const string legalCodes;
  ifstream& inFile_m;
  char gameType_m;        // Accepted values: (t)raditional,(d)iagonal, (s)ixy
  int gameSize_m;

  // Member Functions
  bool validate(char readChar);
  Board* gameBoard_m;
  Viewer* viewObj_m;
  void markInput();

public:
  Game(ifstream& inputFile);
  virtual ~Game();
  void run();
};