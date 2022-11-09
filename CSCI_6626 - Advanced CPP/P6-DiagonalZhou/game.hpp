//----------------------------------------------------------------------------- 
// File:        game.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project/ver: P5 - Cluster
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#pragma once
#include "tools.hpp"

// Forware declaration for P3
class Board;

class Game {
private:

  // Member Variables
  static const string menuList[6];
  static const string legalCodes;

  ifstream& inFile_m;
  char gameType_m;        // Accepted values: (t)raditional,(d)iagonal, (s)ixy

  // Member Functions
  bool validate(char readChar);
  Board* gameBoard_m;

public:
  Game(ifstream& inputFile);
  ~Game();
  void run();

};