## CPSR register
![image](https://github.com/user-attachments/assets/c00c8e63-ec3d-488e-863d-a0abeea1ab1d)

The condition flags are
| Flag | Bit POS | Description |
| ---- | ------- | ----------- |
| Negative: N | 31 | is 1 if the signed value is negative and cleared if the result is positive or 0. |
| Zero: Z| 30 | Set if the result = 0;  If non-zero number, this flag is cleared.
| Carry: C | 29 | For addition type operations, this flag is set if the result produces an overflow. For subtraction type operation, this flag is set if the result requires a borrow. Also, it’s used in shifting to hold the last bit that is shifted out. |
| OVerflow: V | 28 | For addition and subtraction, this flag is set if a signed overflow occurred. NOTE: Some instruction smay specifically set oVerflow to flag an error condition. |
The Interrupt flags are
• I: When set, disables IRQ interrupts
• F: When set, disables FIQ interrupts
• A: When set, disables imprecise aborts
The Instruction set flags are
• Thumb: 16-bit compact instructions
• Jazelle: Obsolete mode for directly executing Java
bytecodes
The other bits are
• Q: This flag is set to indicate underflow and/or
saturation.
• GE: These flags control the Greater than or Equal
behavior in SIMD instructions.
• E: Is a flag that controls the “endianness” for data
handling.
M is the processor mode such as user or supervisor.

## Branch on Condition
* The branch instruction, at the beginning of this chapter, can take a
modifier that instructs it to only branch if a certain condition flag in the
CPSR is set or clear.
The general form of the branch instructions is
B{condition} label
where {condition} is taken from Table 4-1.
* Table 4-1. Condition codes for the branch instruction
{condition} Flags Meaning
EQ Z set Equal
NE Z clear Not equal
CS or HS C set Higher or same (unsigned >=)
CC or LO C clear Lower (unsigned <)
MI N set Negative
PL N clear Positive or zero
VS V set Overflow
VC V clear No overflow
HI C set and Z clear Higher (unsigned >)
LS C clear and Z set Lower or same (unsigned <=)
GE N and V the same Signed >=
LT N and V differ Signed <
GT Z clear, N and V the same Signed >
LE Z set, N and V differ Signed <=
AL Any Always (same as no suffix)
