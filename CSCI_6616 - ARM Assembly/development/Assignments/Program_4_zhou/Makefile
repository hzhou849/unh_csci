# --------------------------------------------------------------------------------------------
# Makefile GCC ver
# CSCI 6616 - ARM Assembly
# Project: P4 - Calculater add/subtract
# 
# @brief: Multiple file compilation
# --------------------------------------------------------------------------------------------

# TARGET
PROJECT_NAME := p4_calc
# SRCS := $(wildcard *.s)
SRCS := calc.s menu.s addOp.s subOp.s
TARGET_OBJ := $(PROJECT_NAME).o
OBJS := $(patsubst %.s, %.o, $(SRCS))
CXX := gcc

$(info [+] - Building project :$(PROJECT_NAME))

all: $(PROJECT_NAME)

# Required GDB object for debugging
# %.s wildcard for .s file
# $< - Symbol for source file 
# $@ - symbol for output file
# $^ - all pre-reqs seperated by spaces
# <Output>.o : <input>.s
$(OBJS) : $(SRCS)
	as -g $^ -o $(TARGET_OBJ)

$(PROJECT_NAME): $(OBJS)
	$(CXX) -g -O0 -o $(PROJECT_NAME) $(TARGET_OBJ)

clean:
	$(info [!] Cleaning up previous built objects...)
	rm -r  $(TARGET_OBJ) $(PROJECT_NAME)
