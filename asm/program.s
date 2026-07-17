.text
.globl _start

_start:
    addi x1,x0,1
    addi x2,x0,2
    add x3,x1,x2
    add x4,x3,x2
    add x5,x4,x3

loop: 
    j loop
