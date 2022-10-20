//----------------------------------------------------------------------------- 
// File:        game.hpp
// 
// Brief:       A basic controller class for the applicaiton
// 
// Project:     P4 - Square
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
//-----------------------------------------------------------------------------

#include "game.hpp"
#include "board.hpp"



// Class constants
const string Game :: legalCodes = "TtDdSs";
const string Game :: menuList[6] = { "Mark", "Undo", "Redo","Save Game", 
                                      "Restore Game","Quit" };


/// @brief Game - Constructor
/// @param [in] inFile - file to be read
//-----------------------------------------------------------------------------
Game :: Game ( ifstream& inFile ): inFile_m(inFile) {
    inFile >> gameType_m;
    if ( !validate( gameType_m ) ) {
        fatal("\n[!] Fatal Error - Char from file is not a legal character!");
    }
    cout << "[+] Game Type character assigned: " << gameType_m << endl; 
    board_m = new Board(gameType_m, inFile_m);
}


/// @brief Desctructor
//-----------------------------------------------------------------------------
Game :: ~Game () { inFile_m.close();  delete board_m;}


/// @brief run - Print the menu and handle selection loop
//-----------------------------------------------------------------------------
void Game :: 
run() {
    char listValue;
    while ( listValue != 'q' ) {
        cout << *board_m << endl;
        listValue = menu_c( "Sudoku Helper", 6, menuList, "murseq" );
        cout << "\n";
        switch( listValue ) {
            case 'm':
                cout << "[!] Option m-Mark selected" << endl;
                // Call Board::mark() to be implemented later
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
            default:
                cout << "pick something else" << endl;
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
validate ( char rChar ) { 
    string charCompare;

    if ( legalCodes.find(rChar) != string::npos ) { return true; }  
    else { return false; }       // No match found
}