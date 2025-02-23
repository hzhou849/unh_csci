/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 5 Q-notation Add/subtract calculator
	Name: Howard Zhou

	File: calc.s

	Description:
		- Add/subtract 2 digit integer and 2digit fraction number XX.YY only
		- converts to Q8.8 format to be printed


		@ Write syscalls
		R0 - 0=stdin; 1=stdout; 3=stderr
		R2 - stores length of string
		R7 - linux service 3=read; 4=write


		@ Scanf registers:
			R0: pointer to var containing format specifier %d, %c %h etc..
			R1: input data buffer to store char ( requires actual char value ie 0x31 = '1')
		
		@ Printf registers:
			R0: contains address of string data var to print
			R1..R?: args used for variable print

		@ main registers:
			R0-R3 - Temprory work registers
			R4 - Operand1
			R5 - Operand2
			R6 - Menu option value

			if not enough registers to store this, you might have to check on the fly
			R7 - Sign 0=positive; 1=negative
			R8 - Decimal 0=no decimal; 1=decimal '.' found
 * ========================================================================================== 
 */



@ function includes: menus.s, addOps.s, subOpbs.s

@ Define our variables
.EQU _EXIT_CODE, 1

.EQU OPTION_1, 1
.EQU OPTION_2, 2
.EQU OPTION_3, 3
.EQU OPTION_4, 4
.EQU OPTION_5, 5

.global main
.section .text

main:
	MOV R5, #0					@ intialize - Fractional portion
	MOV R7, #0					@ initialize R7=0
	MOV R8, #0					@ initialize R8=0
	BL menu_print				@ print menu; calls menu::menu_print()

	// 1 - Get menu option 
	LDR R0, =menu_fmt_specifer	@ Set the format specifier (%d)
	LDR R1, =menuOpt
	BL scanf					@ call scanf to get value into R1 buffer
	BL getchar					@ flush whitespace in buffer left by scanf				
	LDR R4, =menuOpt			@ loads address of scanf input-data_buf; R4=operand1
	LDR R6, [R4]				@ de-reference R4 to get actual 'char' and place in R6.

	// 3 - check what is selected by user
	CMP R6, #OPTION_1			@ if addition, branch to add()
	BEQ opt1
	CMP R6, #OPTION_2			@ elif 2=subract, branch to subtract()
	BEQ opt2
	CMP R6, #OPTION_3			@ elif 3=multiply, not implemented
	BEQ errmsg
	CMP R6, #OPTION_4			@ elif 4=divide, not implemented										
	BEQ errmsg
	CMP R6, #OPTION_5			@ elif 5= exit
	BEQ exit
	B errmsg					@ else, if invalid entry, goto errmsg

opt1: @ Addition
	BL getOperands
	// update flags
	MOV R7, R2					@ update negative_flag
	MOV R8, R3					@ update decimal point
	MOV R4, R0					@ update R4=operand1
	MOV R5, R1					@ update R5=operand2
	
	MOV R1, R4					@ addOp arg1=operand1
	MOV R2, R5					@ addOp arg2=operand2
	MOV R4, R3					@ arg4 = decimal_flag
	BL addOp					@ Branch to addOp.s 
	B main						@ Restart main loop
	
opt2: @ Subtraction
	BL getOperands
	LDR R1, [R4]				@ addOp arg1=copy operand 1 into R1
	LDR R2, [R5]				@ addOp arg2=R2	
	BL subOp					@ branch to subOp.s
	B main						@ restart main loop

opt3:
	@ TODO: later implementation
opt4:
	@ TODO: later implementation


getOperands: @ Get operands from user input
			 @ Returns: R0 operand1 

	// 1. Get operands are now string types

	// 2. Parse to check for decimal 
	   // check negative char in MSB byte1, 
	   // check for decimals 
	// if decimal convert integer portion 

	PUSH {R4-R8, LR}			@ Save LR on stack 
	
	// get operand1
	LDR R0, =opPrompt			@ load op prompt string
	MOV R1, #1					@ arg for operand 1 
	BL printf					@ print operand prompt str
	LDR R0, =opr_fmt_specifer	@ Set the format specifier (%s)
	LDR R1, =operand1			
	BL scanf					@ call scanf to get value into R1 buffer
	@ MOV R0, #0					@ 0=FD for stdin
	@ BL getchar					@ flush whitespace in buffer left by scanf

	// Print operand1
	LDR R0, =opStr				@ String message wtih variable to be printed
	LDR R4, =operand1			@ load operand address; R4=operand1
	MOV R1, #1					@ arg1: operand counter
	MOV R2, R4					@ arg2: derefence and get oprand1 value; prints %c
	BL printf

	// get operand2
	LDR R0, =opPrompt			@ load op prompt string
	MOV R1, #2					@ arg for operand2 
	BL printf					@ print operand prompt str
	LDR R0, =opr_fmt_specifer	@ Set the format specifier (%s)
	LDR R1, =operand2			
	BL scanf					@ call scanf to get value into R1 buffer
	@ MOV R0, #0					@ 0=FD for stdin
	@ BL getchar					@ flush whitespace in buffer left by scanf

	// Print operand1
	LDR R0, =opStr				@ String message wtih variable to be printed
	LDR R5, =operand2			@ load operand address; R4=operand1
	MOV R1, #2					@ arg1: operand counter
	MOV R2, R5					@ arg2: derefence and get oprand1 value; prints %c
	BL printf


	// check, convert 
	LDR R1, =operand1			@ move operand1 into R1 for convert_num() arg1
	BL start_convert			@ Branch, save LR check for negative sign
	MOV R4, R0					@ save operand1 converted number in R4
	LDR R1, =operand2			@ Load operand2 into R1 and convert
	BL start_convert
	MOV R5, R0					@ save operand2 into R5
	@ //3 - get input - operand2

	// Setup return values
	MOV R0, R4					@ return operand1
	MOV R1, R5					@ return operand2
	MOV R2, R7					@ negative flag
	MOV R3, R8					@ decimal point

	POP {R4-R8, LR}				@ Restore LR from stack will overwrite r4 and r5 values
	BX LR						@ return


start_convert: @ Args: R1=input_operand;  
			   @ return: R0= converted decimal number
	
	@ In fucnction registers:
	@ R1=input operand
	@ R4= whole number of operand
	@ R5= fractional of operand
	@ R6=String buffer for operand conversion
	@ R7=neg_flag; R8=decimal_flag; 

	// 1. Check for negative number
	PUSH {R4-R8, LR}			@ push save registers to stck

	MOV R0, #0					@ R0 = Byte iterator count
	LDRB R2, [R1]				@ Load first byte of operand string
	// If '-' == true, set flag and increment to next character
	CMP R2, #'-'				@ check for '-' (45d; 0x2D)
	MOVEQ R7, #1				@ assign R7 negative flag =1 if '-' found
	ADDEQ R0, R0, #1			@ increment iterator

		//2.  else check for decimal point 
	dec_check:
		LDRB R2, [R1, R0]			@ Iterate byte string
		
		// If null found, we are done
		CMP R2, #0					@ If null char we are done
		BEQ check_done				@ we are done

		// If '.' found set flag, else increment counter, move to next byte repeat
		CMP R2, #'.'				@ Check if R2 contains decimal;  = '.'
		MOVEQ R8, R0				@ set decimal_flag to iterator position
		BEQ check_done

		// else we keep checking next bit			
		ADD R0, R0, #1				@ increment counter for next byte read
		B dec_check					@ go back to top of loop

	check_done: 
		//if decimal found and R0 is greater than 2nd byte, B errmsg
		CMP R8, #1					@ check if we found a decimal at position 2?
		BNE str_dec					@ continue to convert numbers

		// If positive number, decimal is position <2; Negative <3
		CMP R7, #1					@ Check if R7 negative flag is set
		MOVEQ R2, #3				@ if R7 is set, R2 decimal postion should not be >3
		MOVNE R2, #2				@ else R2 should not be >2
		CMP R0, R2
		BGT errmsg					@ if iterator is > position2, error. Decimal too high
	str_dec:
		// Convert ascii to decimal; 0x30|48d =0; to 0x39|57d

		@ // 1. start conversion, check R7 if this is a neg number, R0 iterator
		@ // will start at 1, else 0
		@ CMP R7, #0					@ Check if R7 is 0=positive number
		@ MOV R0, #0					@ Init iterator starts at 0
		LDR R6, =numBuffer			@ R6 will be the tempbuffer to put parsed chars
		
		parse_loop:
			LDRB R2, [R1], #1 		@ load ascii byte into R2 for parsing
			// If null found or decimal. we know the operand is done
			CMP R2, #0					@ if R2 is null, we are done
			BEQ end_convert
			CMP R2, #'.'				@ if R2 is '.' operand1 record decimal place and keep processing
			BEQ parse_loop
			// else, keep parsing str
			STRB R2, [R6] , #1 			@ store R2 number; save post increment
			B parse_loop				@ repeat until done
	
	end_convert: @ process whole number portion of operand
		MOV R2, #0
		STRB R3, [R6]				@ insert \0 to end of string
		LDR R0, =numBuffer			@ load the tempbuffer into R0 for atoi arg1
		BL atoi						@ call atoi to convert the string to decimal number
									@ R0 should have the decimal result now
		MOV R4, R0					@ Move whole number into reserved R4 register
		LDR R0, =result				@ Test result by printing to terminal
		MOV R1, R4
		BL printf
		MOV R0, R4					@ Move the whole number converted operand to R0 to be returned
		POP {R4-R8, LR}				@ restore registers from stack
		BX LR					 	@ Return to getOperands()	

errmsg: 
	LDR R0, =errStr				@ load error string for printf
	BL printf
	B main						@ go back to top(main)

exit:
	BL menu_print_exit			@ exit message; calls menu::menu_print()
	MOV R0, #0					@ exit return code
	MOV R7, #_EXIT_CODE			@ 1=exit service code
	SVC 0

.data
.word 	@ 32bit align all variables
	opStr: .asciz	"Operand[%d] = str: %s\n"
	result: .asciz  "[!] converted operand from memory decimal:  %d \n"
	opPrompt: .asciz	"\nEnter operand %d > "
	errStr: .asciz  "\nOption selected not recognized. Try again...\n"
	
	menu_fmt_specifer: .asciz "%d"
	opr_fmt_specifer: .asciz "%s"	@ used for float
	
	menuOpt:  .space 4, 0		@ 4 bytes, zero initialized
	operand1: .space 32, 0   	@ Needs to be big enough for string  Reserve 32 bytes and fill with zeros
	operand2: .space 32, 0 		@ Reserve 4bytes and fill with zeros
	option_buff: .space 8, 0
	numBuffer:  .space 64, 0	@ 4 bytes, zero initialized

.section .note.GNU-stack, "", %progbits		@ disable GNU stack warning
.end
