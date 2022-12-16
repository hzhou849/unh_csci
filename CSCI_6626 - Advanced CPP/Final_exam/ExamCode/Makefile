#------------------- MAKEFILE for C++ projects w/Debugger option--------------------------------

# Expected object files:
BIN_NAME = main
PROJECT_NAME = Exam Source

# Add names of object files here
SRCS= $(wildcard *.cpp ) $(wildcard */*.cpp)

OBJS= $(patsubst %.cpp,%.o,$(SRCS))
SUBFOLD1=CanView

# Compiler:
CC = g++

# Optional flags:
# 'O'(Letter not zero) optimization level 1. For flow analysis and debug comments
# g3 for maximum debug info
# CFLAGS= -std=c++11 -g -Wall -O1
CFLAGS= -std=c++11 -g3 -Wall

# Header display for terminal
$(info )
$(info Building project: [$(PROJECT_NAME)] - Binary: $(BIN_NAME) )
$(info )
$(info )

all: $(BIN_NAME)


#------------------------- Linking Commands -----------------------------------
# AUTOMATIC VARIABLES
# Example: all: libarary.cpp main.cpp
# $@ = name of target (evaluates all)
# $< = prerequisite required to create output file (evaluates libarary.cpp)
# $^ = Filename of all pre-reqs seperated by spaces(evaluates libarary.cpp main.cpp)
$(BIN_NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(SUBFOLD1)/%.o: CanView/%.cpp 
	$(CC) $(CFLAGS) -o $@ -c $<
	
%.o: %.cpp 
	# $(CC) $(CFLAGS) -o $< -c $@
	$(CC) $(CFLAGS) -o $@


#---------------------- Compilation Commands -----------------------------------
# This tells make all object files are made with the corresponding .c and .h files 
# with the same name
# **DO NOT declare %.h here, unless you want pre-compiled headers and create .h.gch files
%.o: %.cpp
	$(CC) $(CFLAGS) -c $^ 

#---------------------- Cleaning Commands -----------------------------------
clean:
	$(info [!] Removing old builds ....)
	rm -f $(OBJS) $(BIN_NAME)

objclean: 
	rm -f $(OBJS)

