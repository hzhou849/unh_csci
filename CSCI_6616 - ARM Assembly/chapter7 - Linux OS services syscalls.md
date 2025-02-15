# Chapter 7 Linux OS services/syscalls

## Calling conventions
1. ```R0 - R6```: input parameters
2. ```R7```: LInux service call code
3. ```SVC 0```: interrupt to execute syscall
4. ```R0```: Return code from syscall
