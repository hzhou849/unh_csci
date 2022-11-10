#------------------- MAKEFILE for C++ projects w/Debugger option--------------------------------
# TODO: add a help section printout

# Expected object files:
BIN_NAME = main
PROJECT_NAME = SudokuHelper

# Add names of object files here
OBJS = SudokuMain-Zhou.o state.o tools.o game.o board.o square.o cluster.o diagBoard.o

# Compiler:
CC = g++

# Optional flags:
# 'O'(Letter not zero) optimization level 1. For flow analysis and debug comments
# g3 for maximum debug info
# CFLAGS= -std=c++11 -g -Wall -O1
CFLAGS= -std=c++11 -g3 -Wall

# Header display for terminal
$(info Running: [$(PROJECT_NAME)] - $(BIN_NAME) )
$(info )
$(info )

all: $(BIN_NAME)

# this is the sequence to follow if debug, it has to be called this way.
# notice the called to $(BIN_NAME), this also helps with VSC debugger launch.json
debug: clean
debug: CFLAGS+= -DDBUG -g
# debug: $(BIN_NAME)
debug: dbuild

#------------------------- Linking Commands -----------------------------------
# AUTOMATIC VARIABLES
# Example: all: libarary.cpp main.cpp
# $@ = name of target (evaluates all)
# $< = prerequisite required to create output file (evaluates libarary.cpp)
# $^ = Filename of all pre-reqs seperated by spaces(evaluates libarary.cpp main.cpp)
$(BIN_NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# The debug file name will also change to reflect 'dbuild'
dbuild: $(OBJS)
	$(info)
	$(info [+] Debug build)
	$(CC) $(CFLAGS) -o $@ $^


#---------------------- Compilation Commands -----------------------------------
# This tells make all object files are made with the corresponding .c and .h files with the same name
# **DO NOT declare %.h here, unless you want pre-compiled headers and create .h.gch files
%.o: %.cpp
	$(CC) $(CFLAGS) -c $^ 

#---------------------- Cleaning Commands -----------------------------------


clean:
	$(info [!] Removing old builds ....)
	rm -f $(OBJS) $(BIN_NAME)

objclean: 
	rm -f $(OBJS)

