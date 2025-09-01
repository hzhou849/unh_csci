## Single Double precision floating point numbers

## Printf
* this requires specific process to print
* Numbers need to be stored as ```.single``` or ```.double```
* Single must be converted to .double 64 in order for printf to work
* You can only pass one argument starting at ```{r2, R3}```, next argment will have
  to be pushed to the stack to print properly 
```asm
    MOV R1, #CHAR_A
    /// Printf requires singles to be converted to doubles starting at R2
    
    // Value 1
    LDR R2, =f1                     @ Load address f1 into R2
    VLDR.f32 S2, [R2]               @ Load R2(f1) value into S2 register
    VCVT.f64.f32 D1, S2             @ convert S2 to a double in D1
    // we need to convert to double
    LDR R0, =result_double          @ load double into R2
    VSTR.f64 D1, [r0]               @ Write D1 into result_double variable
    LDM R0, {R2, R3}                @ Load R0(result_double) across R2 and R3 (32+32bit)

    // Value 2
    LDR R4, =f2
    VLDR.f32 S2, [R4]
    VCVT.f64.f32 D1, S2
    LDR R0, =result_double
    VSTR.f64 D1, [R0] 
    LDM R0, {R6, R7}
    PUSH {R6, R7}                   @ additional values need to pushed to the stack to print

    LDR R0, =print_value            @ Load the print string
    BL printf                       @ now we can finally print
```
