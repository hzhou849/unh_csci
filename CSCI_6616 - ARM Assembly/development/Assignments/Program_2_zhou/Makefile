# --------------------------------------------------------------------------------------------
# Makefile for project 2
# CSCI 6616 - ARM Assembly
# Howard Zhou
#
# --------------------------------------------------------------------------------------------

PROJECT_NAME = p2_counter_64k
OBJS = $(PROJECT_NAME).o

$(info [+] - Compiling project: $(PROJECT_NAME))

ifdef DEBUG
	BUILD = gcc
	DEBUG_FLAG = -g
	OUTPUT_FILE = debug_build_$(PROJECT_NAME)
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
	$(BUILD) $(DEBUG_FLAG) -O0 -o $(OUTPUT_FILE) $(OBJS)

clean:
	$(info [!] - Cleaning up all build files)
	rm $(OBJS) $(OUTPUT_FILE) debug_build_$(PROJECT_NAME)