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

#include "game.hpp"

/// @brief Game - Constructor
/// @param [in] fileName - file to be read
//-----------------------------------------------------------------------------
Game :: Game ( const string& fileName ) {
    inputFile_m.open(fileName, ios_base::in);

    if (!inputFile_m) {
        fatal("Fatal Error! - Game() failed to open file.");
    }

    cout << "file read successfully: " << endl;
    // string text;
    // char testChar;

    // // Or are we using >> ? 
    // inputFile_m >> std::ws; // skip all whitespaces for this ifstream object

    // inputFile_m.get(testChar) ; 

    // std::cout << "test read: " << testChar << endl;
    // inputFile_m >> testChar;
    // std::cout << "test read2: " << testChar << endl;


    // // Check for eof()
    // inputFile_m.close();

    gameType_m = inputFile_m.get();
   
    
    // Return type is bool so 
    if ( !validate( gameType_m ) ) {
        fatal("Fatal Error! -  No Legal Character found in input file.");
        fatal("[!] Fatal Error - Char from file is not a legal character!");
    }
    else {
        cout << "[+] Game Type character assigned: " << gameType_m << endl; 
    }




    
    
}


/// @brief run - Print the menu
// /// @return   exit success; exit failure
//-----------------------------------------------------------------------------
void Game :: 
run() {
    bool loopRun = true;
    
    // while (loopRun) {
    //     for (int iter=0; iter<6; iter++){
            
    //     }

    // }

     const char* MENU_LIST2[6] = { "MenuItem1", 
                                    "MenuItem2",
                                    "MenuItem3",
                                    "MenuItem4",
                                    "MenuItem5",
                                    "MenuItem6"
                                  };

    menu_c( "SUDOKU Game", 6, MENU_LIST2), "123456";

    // Write a function to display the menu 
    for (int iter=0; iter < 6; iter++) {
        cout << MENU_LIST[iter];
    }
    cout << endl;           // Flush and newline

    // return 0;
}


/// @brief Checks the character read is legal
/// @param [in] readChar - Character read from input file.
/// @return  true = Success; false = Illegal character
//-----------------------------------------------------------------------------
bool Game :: 
validate(const char& readChar) { 

    const string tempChar {readChar};
    string charCompare;

    cout << "Character read from file: " << gameType_m << std::endl;

    for (string::const_iterator itStr = LEGAL_CODES.begin(); 
            itStr != LEGAL_CODES.end(); 
            itStr++ ) {
        charCompare = *itStr;
        if ( tempChar.compare(charCompare) == 0 ) {
            cout  << "[+] Legal character found: " << endl;
            return true;
        } 
    }

    return false;       // No match found
}

