# Make file for ASM
# To rebuild an already built project use make -B
# To debug in terminal run 'make DEBUG=1' or set env DEBUG=1 

# Link the object to create binary
# HelloWorld: HelloWorld.o
#	ld -o HelloWorld HelloWorld.o

# @ Printout for ARM Raspberry pi make 
# $(info <message>)
# $(Warning <message>)
# $(error <message>) - CAREFULL, this will supress actual error msgs

# Create the object file
#HelloWorld.o: HelloWorld.s
#	as -o HelloWorld.o HelloWorld.s

#-----------------------------------------------------------------------------------------------------
# %..s - Wildcard for any .s file
# $< - symbol for a source file
# $@ - symbol for output file

# Advanced version

OBJS = HelloWorld.o
ifdef DEBUG
	DEBUG_FLAG = -g
	OUTPUT_FILE = DebugVer
else
	DEBUG_FLAG = 
	OUTPUT_FILE = HellowWorld
endif

$(info [+]debug $(OBJS))

# Building object file
# <output.o> : <input_source.s>
%.o: %.s
	as $(DEBUG_FLAG) $< -o $@

HelloWorld: $(OBJS)
	ld -o $(OUTPUT_FILE) $(OBJS)


clean:
	rm $(OBJS) $(OUTPUT_FILE) DebugVer
	$(error [+] Warning message )
