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
static const char* MENU_LIST[6] = { "MenuItem1", 
                                    "MenuItem2",
                                    "MenuItem3",
                                    "MenuItem4",
                                    "MenuItem5",
                                    "MenuItem6"
                                  };
// Game codes
static const char gCodeTrad = 't';
static const char gCodeDiag = 'd';
static const char gCodeSixy = 's';


//-----------------------------------------------------------------------------
/// @brief Class Board
class Board;

class Game {
private:
        std::string firstItem = MENU_LIST[1];

        Board* board_m;
        int  gameSize_m;     // Only accepted values are 6 and 9;
        
        char gameType_m;    // Accepted values are: 
                            // 't'traditional 
                            // 'd'-diagonal
                            // 's' sixy

        ifstream inputFile_m;

public:
    Game(string fileName);
    ~Game() =default;
    int run();

};