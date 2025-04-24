# --------------------------------------------------------------------------------------------
# Makefile GCC ver
# CSCI 6616 - ARM Assembly
# Project:  Final Project - Jarvis Tactical Data Processor
# 
# @brief: Multiple file compilation
# --------------------------------------------------------------------------------------------

# TARGET
PROJECT_NAME := fp_jarvis_tdp
# SRCS := $(wildcard *.s)
SRCS := main.s menu.s modN.s ringbuffer.s str_parser.s data_loader.s
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
	# $(CXX) -march="armv8-a" -mfloat-abi=hard -mfpu=neon -g -O0 -o $(PROJECT_NAME) $(TARGET_OBJ)
	# $(CXX) -mfloat-abi=hard -march="armv7-a" -g -O0 -o $(PROJECT_NAME) $(TARGET_OBJ)
	$(CXX) -mfloat-abi=hard -mfpu=neon -g -O0 -o $(PROJECT_NAME) $(TARGET_OBJ)

clean:
	$(info [!] Cleaning up previous built objects...)
	rm -r  $(TARGET_OBJ) $(PROJECT_NAME)
