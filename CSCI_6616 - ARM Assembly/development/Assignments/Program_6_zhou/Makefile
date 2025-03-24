# --------------------------------------------------------------------------------------------
# Makefile GCC ver
# CSCI 6616 - ARM Assembly
# Project: P5 - Ring Buffer
# 
# @brief: Multiple file compilation
# --------------------------------------------------------------------------------------------

# TARGET
PROJECT_NAME := p6_ring_buffer
# SRCS := $(wildcard *.s)
SRCS := main.s menu.s modN.s
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
	$(CXX) -march="armv7-a" -g -O0 -o $(PROJECT_NAME) $(TARGET_OBJ)

clean:
	$(info [!] Cleaning up previous built objects...)
	rm -r  $(TARGET_OBJ) $(PROJECT_NAME)
