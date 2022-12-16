// ---------------------------------------------------------------------------- 
// File:        main.cpp
// 
// Project/ver:  P11 - Sixy
// Class:       CSCI 6626 - Advanced C++ Design Priciples/OOP
// Professor:   Dr. Alice E. Fischer
// Name:        Howard Zhou
// ----------------------------------------------------------------------------

#include <iostream>
#include "state.hpp"
#include "game.hpp"
#include "board.hpp"
#include "myExcept.hpp"


int main (int argc, char* argv[]) {
    banner();
    try{
        if (argc < 2) {
            throw StreamFatal("Usage:  " + string(argv[0]) + " <input filename>\n"); 
        }

        cout << "Attempting to open file: " << argv[1] << endl;
        ifstream inputFile( argv[1] );
        
        if ( !inputFile.good())  {
            throw StreamFatal(" Unable to open file! " +string(argv[1]) + "\n");
        }
        
        // Run game which will call Board inside the class
        Game gameObj(inputFile);
        gameObj.run();
    
    }
    // Catch all 3 types of Bad errors.
    catch (GmError& bx) { bx.print(); }
    catch (StreamErr& se) { se.print(); }
    catch (const exception& er) { cout << er.what() << endl; }
    catch (...) { cout << "Last-ditch effor to catch exceptions." << endl; }

    bye();
}


