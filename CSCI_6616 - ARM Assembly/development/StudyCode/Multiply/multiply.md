# Mutlipication ARM commands

| Multiply Command | Description |
| ------- | ----------- |
| MUL{S}  | Simple multiply 32 bit truncate; S is status flag update|
| SMMUL   | Signed version 32bit  |
| SMUL Rn<B/T>, Rm<B/T>  | Signed multiply 16-bit Bottom/top modifiers <br> SMULBB SMULBT etc..|
| UMULL{S} RdLO RdHI, Rn, Rm | Unsigned multiplication long  64 bit |
| SMULL{S} RdLO RdHI, Rn, Rm | signed multiplication long 64-bit |  
| <BR>    | <br> |


| Accumulators | Description |
| ------- | ----------- |
| MLA Rd, Rn, Rm, Ra | multiply with accumulator |
| SMULW Rm<B/T>, Rd, Rn, Rm | Signed multiply with word saturation 32bit(Rn) * 16(Rm top/bottom)| 


## ```MUL{S} /SMMUL	Rd, Rn, Rm```  - simple multiply
 * discregard lower 32bits instead of upper bits
 *  2^n * 2^m = 2^n+m; 
 * only keeps LOWER 32-bits of product
 * UPPER 32-bit is disregarded in Rd
 * S = status flag update N and Z only
 * Will not set C, V flags so you won''t know if you overflowed
 * No signed version
 * All operands are registers; no immediate values
 * Rd cannot be the same as Rn

```asm
 @0x12345678 * 0x1000ABCD = 0x 0123 519F 09AB 6618
        MOV  R0, #0x5678          @ Lower 16bits
        MOVT R0, #0x1234          @ upper 16bits

        MOV  R1, #0xABCD
        MOVT R1, #0x1000
        MUL R3, R0, r1          @ R3=R0*R1 = 09AB 6618(lower only)
```
 

## ```SMUL Rn<B/T>, Rm<B/T>, Rd, Rn, Rm```  
  * Sign multiple 16 bits either top or bottom of Rn, Rm.
```asm
    // 0x12345678 * 0x1000ABCD = 0x 0123 519F 09AB 6618 + 10
        MOV  R0, #0x5678          @ Lower 16bits
        MOVT R0, #0x1234          @ upper 16bits

        MOV  R1, #0xABCD
        MOVT R1, #0x1000

        // Multiple bottom 16 bits of R0 and R1
        SMULBB R2, R0, R1      @ R2 = [5678] * [ABCD] only
```

## ```UMULL{S} RdLO RdHI, Rn, Rm ```-  Unsigned multiplication long  <br> ```SMULL{S} RdLO RdHI, Rn, Rm``` - signed multiplication long  

 * Allows for full 64bit multiplication by storing result in TWO registers
```asm
    //0x12345678 * 0x1000ABCD = 0x 0123 519F 09AB 6618
        MOV  R0, #0x5678          @ Lower 16bits
        MOVT R0, #0x1234          @ upper 16bits

        MOV  R1, #0xABCD
        MOVT R1, #0x1000

        // R2 = Rd LO
        // R3 = Rd HI
        UMULL R2, R3, R0, R1    @ {R2,R3} = R0 * R1
                                @ =0x (upper)0123519F (lower)09AB6618 in R3,R2
```
        

## SMULW Rm<B/T>, Rd, Rn, Rm
    * Signed Multiple with  word saturation
    * Multiples 32bit Rn with extracted 16bits of Rm 
    * used for digital signals processing
    * 32x16=48 bits, but only keeps lower 32bits in result
```asm  
        //0x12345678 * 0x1000ABCD = 0x 0123 519F 09AB 6618
        MOV  R0, #0x5678        @ Rn - Lower 16bits
        MOVT R0, #0x1234        @ upper 16bits

        MOV  R1, #0xABCD        @ Rm value
        MOVT R1, #0x1000

        SMULWB R2, R0, R1       @ Multiple bottom Rm: R2= 0x1234578 * (ABCD)
        SMULWT R2, R0, R1       @ Multiple bottom Rm: R2= 0x1234578 * (1000)
```



#  ACCUMULATER VARIANTS
## MLA Rd, Rn, Rm, Ra - multiple with accumulator
* Accumulator is just Ra added to product after multiplication
* Rd = (Rn*Rm) + Ra
```asm
     //0x12345678 * 0x1000ABCD = 0x 0123 519F 09AB 6618 + 10
        MOV  R0, #0x5678          @ Lower 16bits
        MOVT R0, #0x1234          @ upper 16bits

        MOV  R1, #0xABCD
        MOVT R1, #0x1000

        MOV R2, #10             @ Ra value
        MLA R4, R0, R1, R2      @ R4 = (R0*R1) + R2
```

## SMLAL<Rn B/T>< RmB/T>, RdHI, RdLO, Rn, Rm
* SIgned multiple accumualtor long
```asm
   //0x12345678 * 0x1000ABCD = 0x 0123 519F 09AB 6618 + 10
        MOV  R0, #0x5678          @ Lower 16bits
        MOVT R0, #0x1234          @ upper 16bits

        MOV  R1, #0xABCD
        MOVT R1, #0x1000

        MOV R2, #0                 @ initialize R2=0
        MOV R3, #0                 @ initialize R3=0

        SMLALBB R3, R2, R0, R1     @ [R3:R2] = R0(Bottom) * R1(BOTTOM) + [R3:R2]

        @ [R3:R2] = (5678) * (ABCD) + 0
        @ next iteration will be += result bc accumulating
```


