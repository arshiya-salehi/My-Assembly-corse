# File: utils.asm
# Purpose: To define utilities which will be used in MIPS programs.
# Author: Arshiya Salehi
#
# Subprograms Index:
# 	Exit 		Call syscall with a server 10 to exit the program
# 	PrintNewLine 	Print a new line character (\n) to the console
# 	PrintInt 	Print a string with an integer to the console
# 	PrintString 	Print a string to the console
# 	PromptInt 	Prompt for an int & return it to the calling program.
#
# Modification History
# 12/10/2023 - Initial release


# Subprogram: Exit
# Author: Arshiya Salehi
# Purpose: to use syscall service 10 to exit a program
# Input/Output: None
# Side effects: The program is exited
.text
Exit:
	li $v0, 10
	syscall
	
# Subprogram: PrintNewLine
# Author: Arshiya Salehi
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
# Author: Arshiya Salehi
# Purpose: To print a string to the console
# Input: $a0 - The address of the string to print.
# $a1 - The value of the int to print
# Output: None
# Side effects: The String is printed followed by the integer value.
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
#Return
jr $ra

# Subprogram: PrintString
# Author: Arshiya Salehi
# Purpose: To print a string to the console
# Input: $a0 - The address of the string to print.
# Output: None
# Side effects: The String is printed to the console.
.text
PrintString:
addi $v0, $zero, 4
syscall
jr $ra
# Subprogram: PromptInt
# Author: Arshiya Salehi
# Purpose: To prompt the user for an integer, and
# to return that input value to the caller.
# Input: $a0 - The address of the string to print.
# Output: $v0 - The value the user entered
# Side effects: The String is printed followed by the integer value.

.text
PromptInt:
# Print the prompt, which is already in $a0
li $v0, 4
syscall
# Read the integer. Note: at the end of the syscall the value is
# already in $v0, so there is no need to move it anywhere.
move $a0, $a1
li $v0, 5
syscall
#Return
jr $ra

# Subprogram: PrintIntArrayReverse
# Purpose: print an array of ints in reverse order
# inputs: $a0 - the base address of the array
# 	  $a1 - the size of the array
# Output: $v0 - the data in the stack
# side effects: print the array from last index to the first index

PrintIntArrayReverse:

    addi $sp, $sp, -16      # Stack record
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    move $s0, $a0            # save the base of the array to $s0

    # initialization for counter loop
    # $s1 is the ending index of the loop
    # $s2 is the loop counter
    move $s1, $zero          # initialize index to 0
    addi $s2, $a1, -1        # set loop counter to last index

    la $a0, open_bracket     # print open bracket
    jal PrintString

reverse_loop:

    slti $t0, $s2, 0         # check if loop counter is negative
    bnez $t0, end_reverse_loop

    sll $t0, $s2, 2          # Multiply the loop counter by 4 to get offset
    add $t0, $t0, $s0        # address of array element
    lw $a1, 0($t0)           # Load array element
    la $a0, comma            # Print comma before the element
    jal PrintInt

    subi $s2, $s2, 1         # Decrement loop counter
    b reverse_loop

end_reverse_loop:

    li $v0, 4                # print close bracket
    la $a0, close_bracket
    syscall

    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)           # restore stack and return
    addi $sp, $sp, 16

    jr $ra

.data
open_bracket: .asciiz "[" 
close_bracket: .asciiz "]"
comma: .asciiz ","
