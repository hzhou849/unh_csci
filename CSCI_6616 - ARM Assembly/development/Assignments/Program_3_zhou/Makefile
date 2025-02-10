# --------------------------------------------------------------------------------------------
# Makefile for project 3
# CSCI 6616 - ARM Assembly
# Howard Zhou
#
# --------------------------------------------------------------------------------------------

PROJECT_NAME = p3_decToBin
OBJS = $(PROJECT_NAME).o

$(info [+] - Compiling project: $(PROJECT_NAME))

ifdef DEBUG
	BUILD = gcc
	DEBUG_FLAG = -g
	OUTPUT_FILE = debug_$(PROJECT_NAME)
else
	BUILD = ld
	DEBUG_FLAG =
	OUTPUT_FILE = $(PROJECT_NAME)
endif 

# Build the object files with as
%.o: %.s
	as $(DEBUG_FLAG) -o $@ $<

# linking 
$(OUTPUT_FILE) : $(OBJS)
	$(BUILD) $(DEBUG_FLAG) -O0 -o $(OUTPUT_FILE) $(PROJECT_NAME).s

clean:
	$(info [!] - Cleaning up all build files)
	rm $(OBJS) $(OUTPUT_FILE) debug_$(PROJECT_NAME)