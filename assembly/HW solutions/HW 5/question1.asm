
# File: Program5-5.asm
# Author: Charles Kann
# Purpose: Illustrates implementing a subprogram named PrintNewLine.
.text
main:
# Read an input value from the user
la $a0, prompt
jal PrintInt
move $s0, $v0
la $a0, result
move $a1, $s0
jal PrintInt

.data
prompt: .asciiz "Please enter an integer: "
result: .asciiz "You entered: "
# Subprogram: PrintNewLine
# Author: Charles Kann
# Purpose: to output a new line to the user console
# Input/Output: None
# Side effects: A new line character is printed to the user's console
.text
PrintNewLine:
li $v0, 4
la $a0, __PNL_newline
syscall
jr $ra
.data
__PNL_newline: .asciiz "\n"

# Subprogram: PrintInt
# Author: Charles W. Kann
# Purpose: To print a string to the console
# Input: $a0 - The address of the string to print.
# $a1 - The value of the int to print
# Output: None
# Side effects: The string is printed followed by the integer
.text
PrintInt:
# Print string. The string address is already in $a0
li $v0, 4
syscall
# Print integer. The integer value is in $a1, and must
# be first moved to $a0.
move $a0, $a1
li $v0, 1
syscall
# Print a new line character
jal PrintNewLine
#Return
jr $ra