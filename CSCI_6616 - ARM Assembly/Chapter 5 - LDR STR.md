## LDR STR
The LDR and STR instructions use post-indexed addressing to update their address registers.

STR instructions store a word in memory(RAM).
LDR instructions load a word from memory/RAM.

### LDR
* pre-indexed addressing. This is because the address is calculated and then the data is retrieved using the calculated address
* post-indexed addressing, the data is retrieved first using the base register, then any offset shifting and adding is done
example:
```asm
@ load the address of mynumber into R1 (pointer address)
LDR R1, =mynumber
@ load the word stored at mynumber into R2 (dereference pointer)
LDR R2, [R1] .data
mynumber: .WORD 0x1234ABCD
```
#### LDR address offset

```LDR r1, [pc, #20]```
means pc+20

```asm
Type Meaning
B   Unsigned byte
SB  Signed byte
H   Unsigned halfword (16 bits)
SH  Signed halfword (16 bits)
–   Omitted for word

LDR {type} Rt, =<label>

ex. LDR R1, =string
These constants the Assembler creates are placed at the end of the
.text section which is where the Assembly instructions go. Not in the .data
section. 

ex.2 LDR R1, =0x1234ABCD

This assembles into
The GNU Assembler is helping us out by putting the constant we want
into memory, then creating a PC relative instruction to load it.
ldr r1, [pc, #8]
.word 0x1234abcd
```

#### LDR example with ARRAY
* an array of ten words (4 bytes each) defined by
```asm
arr1: .FILL 10, 4, 0
Let’s load the array’s address into R1:
LDR R1, =arr1
```
* To access elements and load the first element
``` LDR R2, [R1]```
* To load element 3, its position 2(0-indexed) Each word is 4-bytes, so we need to multiply by 4
* Address 8 will hold the third element

ie if base address of R1 = 0x1000, element 3 will be at 0x10008
|  Address|  Element  |
| --- | --- |
| 0x...     | eN |
| 0x1008-11 | e2 |
| 0x1004-07 | e1 |
| 0x1000-03 | e0 |

```asm
LDR R2, [R1, #(2*4)]
```
* To load using a register as an offset
```asm
@ The 3rd element is at 0index 2 so get the address and assign it to R3
MOV R3, #(2 * 4)
@ Add the offset in R3 to R1 to get our element.
LDR R2, [R1, R3]
```
* To count address offset 8th from the end ie 0xFF-8 = 0xF8
```asm
-8 two's complent: 0x0000 1000(0x08) = 0x1111 1000(0xF8)
which will be the 8th address from the bottom
LDR R2, [R1, #-(2*4)]
LDR R2, [R1, -R3]
```
* You can also use LSL left shift by 2 positions since left shift means x2 and right=divide /2
```asm
@ Suppose our array is of WORDs but we only
@ want the low order byte.
MOV R3, #2
@ Shift R3 left by 2 positions to multiply
@ by 4 to get the correct address.
LDR R2, [R1, R3, LSL #2]
```

### LDR Write back
* When the address is calculated by the adds and shfits, the result is not kept(thrown away) after we've loaded the register.
  If this is a loop we may want to keep the calculated address, this saves us from doing a seperate ```ADD``` operation on our index register.
* ``` ! ``` after the instruction tells assembler to set the bit in generated instructino telling CPU to save calculated address
```asm
LDR R2, [R1, R3, LSL #2]!  @ Updates R1 with the value calculated. 
```

### LDR Post-index addressing
* THink pre/post increment, consume the value then update (post) vs update value then increment(pre-inc)
* Recall post-indexed addressing, the data is retrieved first using the base register, then any offset shifting and adding is done
* Example: Load R1 with the memory pointed to by R2, then do R2=R2+R3
```asm
LDR R1, [R2] R3
```
* Example 2: Load R1 with the memory pointed to by R2, then do R2=R2+2 (post increment)
```asm
LDR R1, [R2], #2
```
* Ex.3 Load R1 with memory pointed at by R2, then do R2=R2 + (R3 shifted 2 Left)
```asm
LDR R1, [R2], R3, LSL #2
```


### LDR /STR - Double registers
* You can store double-word (64-bits) by using ```LDRD STRD```
* Takes TWO registes as paramets
Example: Load and storing double word:
```asm
LDR R1, =mydword
LDRD R2, R3, [R1] @ store pointer address contents (deref.) R1 into R2 &R3
STRD R2, R3, [R1] @ Load R2 & R3 back into R1

.data
mydword:  .DWORD 0x1234567887654321
```
