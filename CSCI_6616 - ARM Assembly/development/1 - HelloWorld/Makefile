B_FILES=simple printer
SRC_FILES = $(B_FILES:%=%.s)
O_FILES = $(SRC_FILES:%.s=%.o)
 
all: $(B_FILES) 
 
%: %.s 
	as -o $@.o $<
	ld -o $@ $@.o
 
clean:
	rm -f $(O_FILES) $(B_FILES)