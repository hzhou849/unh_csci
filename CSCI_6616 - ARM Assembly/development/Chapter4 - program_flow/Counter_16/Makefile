# --------------------------------------------------------------------------------------------
# Makefile 
# %.s - Wildcard for any .s file
# $< - Symbol for source file
# $@ = symbole for output file
# --------------------------------------------------------------------------------------------
PROJECT_NAME = counter_16
OBJS = $(PROJECT_NAME).o

$(info [+] Compiling project: $(PROJECT_NAME))

ifdef DEBUG
	DEBUG_FLAG = -g
	OUTPUT_FILE = debug_build_$(PROJECT_NAME)
else
	DEBUG_FLAG =
	OUTPUT_FILE = $(PROJECT_NAME) 
endif

# Method 1: ASM building
# Object building stage
%.o : %.s
	as $(DEBUG_FLAG) $< -o $@

# linking state
$(OUTPUT_FILE) : $(OBJS)
	ld -o $(OUTPUT_FILE) $(OBJS)

# Method 2: GCC
# gcc -g -o $(OUTPUT_FILE) $(PROJECT_NAME).s

clean:
	$(info [!] - Cleaning up all build files)
	rm $(OBJS) $(OUTPUT_FILE) debug_build_$(PROJECT_NAME)

