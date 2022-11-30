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

#include "game.hpp"
#include "board.hpp"
#include "diagBoard.hpp"


// Class constants
const string Game :: legalCodes = "TtDdSs";
const string Game :: menuList[6] = { "Mark", "Undo", "Redo","Save Game", 
                                      "Restore Game","Quit" };


//-----------------------------------------------------------------------------
/// @brief Game - Constructor
/// @param [in] inFile - file to be read
//-----------------------------------------------------------------------------
Game :: Game ( ifstream& inFile ): inFile_m(inFile) {
    gameSize_m = 9; 
    inFile >> gameType_m;
    if ( !validate( gameType_m ) ) {
        throw GmBadGameType ( string(1,gameType_m) );  
    }
    cout << "[+] Game Type character assigned: " << gameType_m << endl; 

    if (gameType_m == 's') { gameSize_m = 6; }
    if (gameType_m == 'd') {
        gameBoard_m = new DiagBoard(gameType_m, inFile_m);
    } else {
        gameBoard_m = new Board(gameType_m, inFile_m);
    }
    cout << "\n-------------------------------------------------------------\n"
         << "Executing inital shoop() on board\n" 
         << "------------------------------------------------------------" << endl;

    gameBoard_m->bdShoop(); 
    viewObj_m = new Viewer(gameSize_m, gameSize_m, *gameBoard_m);
}


//-----------------------------------------------------------------------------
/// @brief Destructor
//-----------------------------------------------------------------------------
Game :: ~Game () { inFile_m.close();  delete gameBoard_m; delete viewObj_m; }


//-----------------------------------------------------------------------------
/// @brief run - Print the menu and handle selection loop
//-----------------------------------------------------------------------------
void Game :: 
run () {
    char listValue;
    while ( listValue != 'q' ) {
        cout << "------------------------------------------------------------\n"
            << "Board:\n" << endl;
            // <<"\n" << *gameBoard_m << endl;
        viewObj_m->show(cout);
        listValue = menu_c( "Sudoku Helper", 6, menuList, "murseq" );
        cout << "\n";
        switch( listValue ) {
            case 'm':
                cout << "[!] Option m-Mark selected" << endl;
                markInput();
                break;
            case 'u':
                cout << "[!] Option u - Undo selected" << endl;
                gameBoard_m->undo();
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
        // cout << "\n---------------------------------------------------------------\n";
    }
}


// //-----------------------------------------------------------------------------
// /// @brief backup state
// void Game :: backupState(){}

//-----------------------------------------------------------------------------
/// @brief helper function to handle prompt for mark() user input.
///        Prompt user for row, col and value of square to mark
//-----------------------------------------------------------------------------
void Game :: 
markInput() {
    char choice[3];     // Store user input [row, col, value to mark]
    
    cout << "\nPlease enter the Row, Column and Value (ex 121): " << flush;
    cin >> choice[0];
    cin >> choice[1];
    cin >> choice[2];

    try { gameBoard_m->mark(choice[0], choice[1], choice[2]); }
    catch ( GmError& ge ) { ge.print(); }
}


//-----------------------------------------------------------------------------
/// @brief Checks the character read is legal
/// @param [in] rChar - Character read from input file.
/// @return  true=Success; false=Illegal character
//-----------------------------------------------------------------------------
bool Game :: 
validate ( char rChar ) { 
    if ( legalCodes.find(rChar) != string::npos ) { return true; }  
    else { return false; }       // No match found
}