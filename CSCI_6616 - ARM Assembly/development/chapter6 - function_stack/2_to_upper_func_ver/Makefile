# --------------------------------------------------------------------------------------------
# Makefile GCC ver
# CSCI 6616 - ARM Assembly
# --------------------------------------------------------------------------------------------

PROJECT_NAME= toupper_func
OBJS= main.o upper.o

$(info [+] - Compiling project: $(PROJECT_NAME))

ifdef DEBUG
	BUILD=gcc
	DEBUG_FLAG= "-g"
	CXX_FLAG = "-O0"
	OUTPUT_FILE = debug_$(PROJECT_NAME)
else
	BUILD = ld
	DEBUG_FLAG =
	CXX_FLAG = 
	OUTPUT_FILE = $(PROJECT_NAME)
endif

# Buuild the object files with assembly compiler
# %.s wildcard for .s file
# $< - Symbol for source file 
# $@ - symbol for output file
# <Output>.o : <input>.s
%.o : %.s
	as $(DEBUG_FLAG) $< -o $@

$(OUTPUT_FILE) : $(OBJS)
	$(BUILD) $(DEBUG_FLAG) -o $(OUTPUT_FILE) $(OBJS)