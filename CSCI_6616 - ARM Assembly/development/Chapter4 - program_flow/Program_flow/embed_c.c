/* Test Embedded assembly
 *
 * gcc -S -O0 main.c -o main.s
 * gcc -g -O0 main.c -o main 
 */

void main() 
{
	__asm__ 
	(

		"_start:\n" 
		"	MVN R0, #2					@ Assign R0 to value 2 and apply NOT 0000 0010 to 1111 1101\n"
		"	ADD R2, #0x001					@ Add 1 for two's complement 1111 1101 + 1 = 1111 1110\n"
		"	MOV R1, #3\n"

	);
}