#pragma once
class Player
{
public:
    std::string get_name() { return name; }
    int get_health() { return health; }
    int get_xp() { return xp; }

    Player(std::string name_val = "None", int health_val = 0, int xp_val = 0);

    // Copy Constructor
    Player(const Player &source);

    // Destructor
    ~Player() { std::cout << "Destructor called for: " << name << std::endl; }

private:
    std::string name;
    int health;
    int xp;
};


// Implementation Player.cpp

Player::Player(std::string name_val, int health_val, int xp_val)
    :name{ name_val }, health{ health_val }, xp{ xp_val }
{
    std::cout << "Three-args constructor for " + name << std::endl;
}

// Copy Constructor Implementation 
Player::Player(const Player &source)
//: name{source.name}, health{source.health}, xp{ source.xp } // you can also replace this with a delegating constructor
    : Player{ source.name, source.health, source.xp } // Delgating constructor 
{
    std::cout << "Copy Constructor - made a copy of : " << source.name << std::endl;
}