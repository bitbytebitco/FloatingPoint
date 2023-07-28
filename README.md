# FloatingPoint_Combinational
This is a repository of floating-point combinational vhdl entities (using ieee_proposed) 


| Operation     | # LUTS        | DSP   | Max Delay (ns)  | IO |
| ------------- | ------------- | ----- | --------------- | -- | 
| Add           | 775           | 0     | 25.431          | 96 |
| Subtract      | 827           | 0     | 25.312          | 96 |
| Multiply      | 539           | 2     | 23.495          | 96 |
| Divide        | 1564          | 0     | 95.01           | 96 |
| Remainder     | 1505          | 0     | 87.44           | 96 |


## Testing Details
+ All synthesis was done using Vivado v2023.1
+ All implementation was tested using the Vivado Internal Logic Analyzer (ILA) and Virtual Input/Output (VIO) IP core on a Basys 3 board
+ All floating-point functions set to use their default parameters
