/* ----------------------------------------------------------------
* PeterRabbit main.cpp
* Created by Alice Fischer on 2/17/06, modified 10/5/19.
* This problem is about items, containers, and OO techniques.
* ------------------------------------------------------------- */

#include <iostream>
//#include "tools.hpp"
#include "Nest.h"
#include "Rabbit.h"


int main()
{
	banner();
	
	Nest burrow(5);
	//burrow.start();
	//Nest burrow;
	cout << "Burrow constructed\n";
	
	Rabbit mom;
	cout << "Mom constructed\n";
	string name;

	burrow.arrive(mom);
	mom.print(cout);

	cout << "New bunnies are on the way\n";

	while (!burrow.full()) {
		cout << " What is the name of this one? ";
		cin >> name;
		Rabbit p(name);
		p.print(cout);
		burrow.arrive(p);
	}

	burrow.print(cout);

	cout << "Boys are sometimes naughty....\n";
	Rabbit q = burrow.leave();
	q.runAway(cout);
	q.print(cout);

	burrow.print(cerr);
	bye();

}

