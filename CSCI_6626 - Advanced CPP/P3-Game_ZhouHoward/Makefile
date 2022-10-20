#------------------- MAKEFILE for C++ projects --------------------------------
# Expected object files:
BIN_NAME = main

# Add names of object files here
OBJS = SudokuMain-Zhou.o state.o tools.o game.o

# Compiler:
CC = g++

# Optional flags:
# 'O'(Letter not zero) optimization level 1. For flow analysis and debug comments
CFLAGS= -std=c++11 -g -Wall -O1

#------------------------- Linking Commands -----------------------------------
# AUTOMATIC VARIABLES
# Example: all: libarary.cpp main.cpp
# $@ = name of target (evaluates all)
# $< = prerequisite required to create output file (evaluates libarary.cpp)
# $^ = Filename of all pre-reqs seperated by spaces(evaluates libarary.cpp main.cpp)
$(BIN_NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

#---------------------- Compilation Commands -----------------------------------
# This tells make all object files are made with the corresponding .c and .h files with the same name
# **DO NOT declare %.h here, unless you want pre-compiled headers and create .h.gch files
%.o: %.cpp
	$(CC) $(CFLAGS) -c $^

#---------------------- Cleaning Commands -----------------------------------
clean:
	rm -f $(OBJS) $(BIN_NAME)

objclean: 
	rm -f $(OBJS)

