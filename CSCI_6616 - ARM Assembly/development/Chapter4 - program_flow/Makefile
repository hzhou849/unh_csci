# Makefile
OBJS = programFlow.o
OUTPUT_FILE = programFlow

ifdef DEBUG
	DEBUG_FLAG = -g
else
	DEBUG_FLAG = ''
endif

# $(info [+] Building project with DEBUG symbols)
# $(info [+] Start - Building project: $(DEBUG_FLAG))

# Object build
# <output.o> : <input_source.s>
%.o: %.s
	as $(DEBUG_FLAG) $< -o $@

# Linker stage
programFlow: $(OBJS)
	ld -o $(OUTPUT_FILE) $(OBJS)

clean:
	rm $(OBJS) $(OUTPUT_FILE)