# FloatingPoint_Combinational
This is a repository of single-precision floating-point combinational vhdl entities (using ieee_proposed) 


| Operation     | N  | # LUTS         | DSP   | Max Delay (ns)  | IO |
| ------------- | -- | -------------- | ----- | --------------- | -- | 
| Add           | 32 | 775            | 0     | 25.431          | 96 |
| Subtract      | 32 | 827            | 0     | 25.312          | 96 |
| Multiply      | 32 | 539            | 2     | 23.495          | 96 |
| Divide        | 32 | 1564           | 0     | 95.01           | 96 |
| Remainder     | 32 | 1505           | 0     | 87.44           | 96 |
| Modulo        | 32 | 2305           | 0     | 109.290         | 96 |
| Reciprocal    | 32 | 2185           | 0     | 98.527          | 64 |
| Dividebyp2    | 32 | 341            | 0     | 13.191          |128 |
| Mac           | 32 | 1492           | 2     | 34.808          |128 |


## Testing Details
+ All synthesis was done using Vivado v2023.1
+ All implementation was tested using the Vivado Internal Logic Analyzer (ILA) and Virtual Input/Output (VIO) IP core on a Basys 3 board
+ All floating-point functions set to use their default parameters
    + All operations were done using float32 numbers (single-precision) 

## Assembly Example using the Floating-Point Module as a Perhipheral 
```

.text
.globl _start


.equ F_A, 0xFF1
.equ F_B, 0xFF2
.equ F_RESULT, 0xFE1
.equ F_STAT, 0xFE2
.equ F_CTL, 0xFF3
.equ EN, 0x01
.equ DONE_CLEAR, 0x02
.equ A1, 0x41A40000             # 20.5 float32
.equ B1, 0x420F0000             # 35.75 float32 

.equ A2, 0xC20F0000             # -35.75 
.equ B2, 0x41A40000             # 20.5

.equ A3, 0x420F0000             # 35.75
.equ B3, 0x41B40000             # 22.5

.equ A4, 0x41460000             # 12.375 
.equ B4, 0xC0B00000             # -5.5

.equ A5, 0xC1460000             # -12.375
.equ B5, 0x40B00000             # 5.5

_start :
    # constants
    li s3, DONE_CLEAR          # 0b10 
    li t4, F_CTL
    li t5, F_STAT
    li t6, F_RESULT
    addi t3,x0,1                

    # set input ctrl addresses to registers
    li a0, F_A 
    li a1, F_B


_p1:
    # load inputs
    li a4, A1
    li a5, B1
    call _set_and_poll
    j _p2

_p2:
    # load inputs
    li a4, A2
    li a5, B2
    call _set_and_poll
    j _p3

_p3:
    # load inputs
    li a4, A3
    li a5, B3
    call _set_and_poll
    j _p4

_p4:
    # load inputs
    li a4, A4
    li a5, B4
    call _set_and_poll
    j _p5

_p5:
    # load inputs
    li a4, A5
    li a5, B5
    call _set_and_poll
    j _p1


_set_and_poll:
    sw a4, 0(a0)               # set F_A 
    sw a5, 0(a1)               # set F_B

    sw t3, 0(t4)               # update F_CTRL to 0b01
    lb a6, 0(t5)               # load F_STAT 
    bltu a6, t3, _set_and_poll

    lw a2, 0(t6)               # load 0xFE1 (f_R) to t0
    sw s3, 0(t4)               # update F_CTRL to 0b01

    ret 

.section .rodata
```
