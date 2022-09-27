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
Game :: Game ( ifstream& inputFile ) {
 
    gameType_m = inputFile.get();
   
    
    // Return type is bool so 
    if ( !validate( gameType_m ) ) {
        fatal("\n[!] Fatal Error - Char from file is not a legal character!");
    }
    else {
        cout << "[+] Game Type character assigned: " << gameType_m << endl; 
    }

    
}

/// @brief run - Print the menu and handle selection loop
//-----------------------------------------------------------------------------
void Game :: 
run() {
    char listValue;
    bool loopRun = true;
     
    // *tools.hpp does not support this yet - waiting for Dr. Fischer to update file
    // in the meantime, modified option to create menu list

    while ( loopRun ) {
        listValue = menu_c( GAME_TITLE, 6, MENU_LIST, MENU_OPTIONS );
        cout << "\n";
        switch( listValue ) {
            case 'm':
                cout << "[!] Option m-Mark selected" << endl;
                // Call Board::mark() for later
                break;
            case 'u':
                cout << "[!] Option u - Undo selected" << endl;
                break;
            case 'r':
                cout << "[!] Option r - Redo selected" << endl;
                break;
            case 'e':
                cout << "[!] Option e - Restore selected" << endl;
                break;
            case 'q':
                cout << "[!] Option q - Quit selected" << endl;
                loopRun = false;
                break;
            default :
                cout << "[!] No valid option selected!" << endl;
                break;

        }

        cout << "\n---------------------------------------------------------------" << endl;
    }
}

/// @brief Checks the character read is legal
/// @param [in] readChar - Character read from input file.
/// @return  true=Success; false=Illegal character
//-----------------------------------------------------------------------------
bool Game :: 
validate (const char& readChar) { 

    const string tempChar {readChar};
    string charCompare;

    cout << "Character read from file: " << gameType_m;

    for (string::const_iterator itStr = LEGAL_CODES.begin(); 
            itStr != LEGAL_CODES.end(); 
            itStr++ ) {
        charCompare = *itStr;
        if ( tempChar.compare(charCompare) == 0 ) {
            cout  << "[+] Legal character found! " << endl;
            return true;
        } 
    }

    return false;       // No match found
}