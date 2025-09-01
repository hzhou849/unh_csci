# --------------------------------------------------------------------------------------------
# Makefile GCC ver
# CSCI 6616 - ARM Assembly
# --------------------------------------------------------------------------------------------

PROJECT_NAME= ascii_to_upper
OBJS = $(PROJECT_NAME).o

$(info [+] - Compiling project: $(PROJECT_NAME))

ifdef DEBUG
	BUILD = gcc
	DEBUG_FLAG = "-g -O0"
	OUTPUT_FILE = debug_build_$(PROJECT_NAME)
else
	BUILD = ld
	DEBUG_FLAG = 
	OUTPUT_FILE = $(PROJECT_NAME)
endif

# Build the object files with as compiler
# %.s - wildcard for any .s file
# $<  - symbol for source file
# $@  - symbol for output file
# <output>.o : <input>.s
%.o : %.s
	as $(DEBUG_FLAG) $< -o $@

$(OUTPUT_FILE) : $(OBJS)
	# ld $(DEBUG_FLAG) -o$(OUTPUT_FILE) $(OBJS)
	# for gcc 
	$(BUILD) $(DEBUG_FLAG) -O0 -o$(OUTPUT_FILE) $(OBJS)

clean:
	$(info [!] - Cleaning up all build files)
	rm $(OBJS) $(OUTPUT_FILE) debug_build_$(PROJECT_NAME)

