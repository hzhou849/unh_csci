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

// Class constants
const string Game :: legalCodes = "TtDdSs";
const string Game :: menuList[6] = { "Mark", "Undo", "Redo","Save Game", 
                                      "Restore Game","Quit"};


/// @brief Game - Constructor
/// @param [in] inFile - file to be read
//-----------------------------------------------------------------------------
Game :: Game ( ifstream& inFile ): inFile_m(inFile) {
    // inFile >> gameType_m;
    gameType_m = inFile.get();
    cout << "wtf: " << gameType_m << endl;
    if ( !validate( gameType_m ) ) {
        fatal("\n[!] Fatal Error - Char from file is not a legal character!");
    }
    else {
        cout << "[+] Game Type character assigned: " << gameType_m << endl; 
    }
}


/// @brief Desctructor
//-----------------------------------------------------------------------------
Game :: ~Game () { inFile_m.close(); }


/// @brief run - Print the menu and handle selection loop
//-----------------------------------------------------------------------------
void Game :: 
run() {
    char listValue;
    while ( listValue != 'q' ) {
        listValue = menu_c( "Sudoku Helper", 6, menuList, "murseq" );
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
                break;
        }
        cout << "\n---------------------------------------------------------------\n";
    }
}

/// @brief Checks the character read is legal
/// @param [in] rChar - Character read from input file.
/// @return  true=Success; false=Illegal character
//-----------------------------------------------------------------------------
bool Game :: 
validate (char rChar) { 
    const string tempChar {rChar};
    string charCompare;

    cout << "Character read from file: " << gameType_m;

    // for (string::const_iterator itStr = legalCodes.begin(); 
    //         itStr != legalCodes.end(); 
    //         itStr++ ) {
    //     charCompare = *itStr;
    //     if ( tempChar.compare(charCompare) == 0 ) {
    //         cout  << "[+] Legal character found! " << endl;
    //         return true;
    //     } 
    // }

    if (legalCodes.find(rChar)  != string::npos ) return true; 
    else return false;       // No match found
}