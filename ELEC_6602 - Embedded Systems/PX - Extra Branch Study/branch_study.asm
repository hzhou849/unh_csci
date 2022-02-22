_main:
;branch_study.c,12 :: 		void main()
;branch_study.c,17 :: 		BMI_EX1:
BMI_EX1:
;branch_study.c,18 :: 		MOV R0, #1
MOV	R0, #1
;branch_study.c,19 :: 		MOV R1, #3
MOV	R1, #3
;branch_study.c,20 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,21 :: 		BMI BMI_EX1 // BRANCHES R1-R0 = 1-3 = -2; N=1 Negative TRUE
BMI	BMI_EX1
;branch_study.c,23 :: 		BMI_EX2:
BMI_EX2:
;branch_study.c,24 :: 		MOV R0, #15
MOV	R0, #15
;branch_study.c,25 :: 		MOV R1, #13
MOV	R1, #13
;branch_study.c,26 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,27 :: 		BMI BMI_EX2 // R0-R1 = 15-13 = 2; N=0 Positive - FALSE
BMI	BMI_EX2
;branch_study.c,31 :: 		BEQ_EX1:
BEQ_EX1:
;branch_study.c,32 :: 		MOV R0, #1
MOV	R0, #1
;branch_study.c,33 :: 		MOV R1, #1
MOV	R1, #1
;branch_study.c,34 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,35 :: 		BEQ BEQ_EX1   //  BRANCHES R0-R1 = 0; Z = 1 Both numbers are equal TRUE
BEQ	BEQ_EX1
;branch_study.c,36 :: 		BEQ_EX2:
BEQ_EX2:
;branch_study.c,37 :: 		MOV R0, #29
MOV	R0, #29
;branch_study.c,38 :: 		MOV R1, #30
MOV	R1, #30
;branch_study.c,39 :: 		CMP R0, R1     // R0-R1 = -1; Z = 0, Numbers are not the same FALSE
CMP	R0, R1
;branch_study.c,40 :: 		BEQ BEQ_EX2
BEQ	BEQ_EX2
;branch_study.c,44 :: 		BCS_EX1:
BCS_EX1:
;branch_study.c,45 :: 		MOV R0, #100
MOV	R0, #100
;branch_study.c,46 :: 		MOV R1, #99
MOV	R1, #99
;branch_study.c,47 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,48 :: 		BCS BCS_EX1     //  BRANCHES TRUE Compare R0 is >= R1? 100 > 99
BCS	BCS_EX1
;branch_study.c,49 :: 		BCS_EX2:
BCS_EX2:
;branch_study.c,50 :: 		MOV R0, #100
MOV	R0, #100
;branch_study.c,51 :: 		MOV R1, #100
MOV	R1, #100
;branch_study.c,52 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,53 :: 		BCS BCS_EX2     //  BRANCHES TRUE Compare R0 is >= R1? 100=100
BCS	BCS_EX2
;branch_study.c,54 :: 		BCS_EX3:
BCS_EX3:
;branch_study.c,55 :: 		MOV R0, #67
MOV	R0, #67
;branch_study.c,56 :: 		MOV R1, #21
MOV	R1, #21
;branch_study.c,57 :: 		CMP R1, R0
CMP	R1, R0
;branch_study.c,58 :: 		BCS BGT_EX1     // FALSE R1(21) not greater than R0(67)
BCS	BGT_EX1
;branch_study.c,62 :: 		BGT_EX1:
BGT_EX1:
;branch_study.c,63 :: 		MOV R0, #70
MOV	R0, #70
;branch_study.c,64 :: 		MOV R1, #80
MOV	R1, #80
;branch_study.c,65 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,66 :: 		BGT BGT_EX1 // 70 Not greater 80; Z=0, N!=V FALSE
BGT	BGT_EX1
;branch_study.c,67 :: 		BGT_EX2:
BGT_EX2:
;branch_study.c,68 :: 		MOV R0, #10
MOV	R0, #10
;branch_study.c,69 :: 		MOV R1, #10
MOV	R1, #10
;branch_study.c,70 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,71 :: 		BGT BGT_EX2 // FALSE; R0==R1, Z=1
BGT	BGT_EX2
;branch_study.c,72 :: 		BGT_EX3:
BGT_EX3:
;branch_study.c,73 :: 		MOV R0, #30
MOV	R0, #30
;branch_study.c,74 :: 		MOV R1, #8
MOV	R1, #8
;branch_study.c,75 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,76 :: 		BGT BGT_EX3 // Branches; TRUE 30 > 8, Z=0 N==V
BGT	BGT_EX3
;branch_study.c,80 :: 		BHI_EX1:
BHI_EX1:
;branch_study.c,81 :: 		MOV R0, #1
MOV	R0, #1
;branch_study.c,82 :: 		MOV R1, #2
MOV	R1, #2
;branch_study.c,83 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,84 :: 		BHI BHI_EX1 // C=0, Z=0; R0 < R1; FALSE
BHI	BHI_EX1
;branch_study.c,85 :: 		BHI_EX2:
BHI_EX2:
;branch_study.c,86 :: 		MOV R0, #25
MOV	R0, #25
;branch_study.c,87 :: 		MOV R1, #25
MOV	R1, #25
;branch_study.c,88 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,89 :: 		BHI BHI_EX2 //  Z=1 R0=R1; FALSE
BHI	BHI_EX2
;branch_study.c,90 :: 		BHI_EX3:
BHI_EX3:
;branch_study.c,91 :: 		MOV R0, #100
MOV	R0, #100
;branch_study.c,92 :: 		MOV R1, #50
MOV	R1, #50
;branch_study.c,93 :: 		CMP R0, R1
CMP	R0, R1
;branch_study.c,94 :: 		BHI BHI_EX3 // BRANCHES; C=1 Z=0; 100 > 50 TRUE
BHI	BHI_EX3
;branch_study.c,97 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
