//=============================================================================
// Square Class - Derived from State
//=============================================================================

#include "state.hpp"

class Square : public State {
private: 
    State stateObj;
    short sqRow;
    short sqCol;
    // std::vector<Square*> nbrSquare;  // as per instructions, used later

public:
    Square ()=default;
    Square (char charIn, short row, short col);
    ~Square();

    ostream& print (ostream& os);
    void mark(char newChar);
};

inline ostream& operator << (ostream& os, Square& sqr) {
    return sqr.print(os);
}