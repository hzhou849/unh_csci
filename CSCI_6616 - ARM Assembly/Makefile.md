## Makefile for ASM

#### Best version so far
* Should handle multiple source files
* clean works to cleanup all objects and binary executables
* must use ```as``` builder to build object first with debug flag othewise GDB will not work
```make
# --------------------------------------------------------------------------------------------
# Makefile GCC ver
# CSCI 6616 - ARM Assembly
# Project: P4 - Calculater add/subtract
# 
# @brief: Multiple file compilation
# --------------------------------------------------------------------------------------------

PROJECT_NAME := p4_calc  # TARGET
# SRCS := addOps.s calc.s menu.s subOps.s
SRCS := calc.s 
OBJS := $(patsubst %.s, %.o, $(SRCS))
CXX := gcc

$(info [+] - Building project :$(PROJECT_NAME))

all: $(PROJECT_NAME)

# Required GDB object for debugging
$(OBJS) : $(SRCS)
	as -g $(SRCS) -o $(OBJS)

$(PROJECT_NAME): $(OBJS)
	$(CXX) -g -O0 -o $(PROJECT_NAME) $(OBJS)

clean:
	$(info [!] Cleaning up previous built objects...)
	rm -r $(OBJS) $(PROJECT_NAME)

```
