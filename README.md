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


## Testing Details
+ All synthesis was done using Vivado v2023.1
+ All implementation was tested using the Vivado Internal Logic Analyzer (ILA) and Virtual Input/Output (VIO) IP core on a Basys 3 board
+ All floating-point functions set to use their default parameters
    + All operations were done using float32 numbers (single-precision) 
