# File:	utils.asm
# Purpose:	To define utilities which will be used in MIPS programs.
# Author:	Arshiya Salehi
# 
# Title to and ownership of all intellectual property rights 
# in this file are the exclusive property of Charles W. Kann.
#
# Subprograms Index:
#   Exit 		Call syscall with a server 10 to exit the program
#   PrintNewLine	Print a new line character (\n) to the console
#   PrintInt	Print a string with an integer to the console
#   PrintString	Print a string to the console
#   PromptInt	Prompt for an int & return it to the calling program.
#
# Modification History
#     12/27/2014 - Initial release

# Subprogram:	Exit
# Author:  		Charles Kann
# Purpose:		to use syscall service 10 to exit a program
# Input/Output:	None
# Side effects:	The program is exited

.text
Exit:
    li $v0, 10
    syscall

# Subprogram:	PrintNewLine
# Author:  		Charles Kann
# Purpose:		to output a new line to the user console
# Input/Output:	None
# Side effects:	A new line character is printed to the user's console

.text
PrintNewLine:
    li $v0, 4
    la $a0, __PNL_newline
    syscall 
    jr $ra

.data
   __PNL_newline:   .asciiz "\n"


# Subprogram: 	PrintInt
# Author:		Charles W. Kann
# Purpose:		To print a string to the console
# Input:		$a0 - The address of the string to print.
#			$a1 - The value of the int to print
# Output:		None
# Side effects:	The String is printed followed by the integer value.

.text
PrintInt: 
    # Print string.  The string address is already in $a0
    li $v0, 4
    syscall
    
    # Print integer.   The integer value is in $a1, and must
    # be first moved to $a0.
    move $a0, $a1
    li $v0, 1
    syscall
    
    #Return
    jr $ra

# Subprogram: 	PrintString
# Author:		Charles W. Kann
# Purpose:		To print a string to the console
# Input:		$a0 - The address of the string to print.
# Output:		None
# Side effects:	The String is printed to the console.

.text
PrintString: 
    addi $v0, $zero, 4
    syscall
    jr $ra

# Subprogram: 	PromptInt
# Author:		Charles W. Kann
# Purpose:		To print the user for an integer input, and
#               	to return that input value to the caller.
# Input:		$a0 - The address of the string to print.
# Output:		$v0 - The value the user entered
# Side effects:	The String is printed followed by the integer value.

.text
PromptInt: 
    # Print the prompt, which is already in $a0
    li $v0, 4
    syscall
    
    # Read the integer.  Note: at the end of the syscall the value is
    # already in $v0, so there is no need to move it anywhere.
    li $v0, 5
    syscall
    
    #Return
    jr $ra

# Subprogram: NOR
# Author: Arshiya Salehi
# Purpus: Perform the NOR operation on two input parameters
# Input: $a0 - first input parameter
#	 $a1 - second input parameter
#	 #v0 - result of the NOR operation
# side effects: None

.text
NOR:
	nor $v0,$a0,$a1
	jr $ra
	
# Subprogram: NAND
# Author: Charles Kann
# Purpose: Perform the NAND operation on two input parameters
# Input: $a0 - First input parameter
#        $a1 - Second input parameter
# Output: $v0 - Result of the NAND operation
# Side effects: None

.text
NAND:
    and $t0, $a0, $a1    # Perform AND operation
    nor $v0, $t0, $t0    # Perform NOR operation on the result
    jr $ra
    
# Subprogram: Mult4
# Author: Charles Kann
# Purpose: Multiply an input parameter by 4 using the shift operation
# Input: $a0 - Input parameter
# Output: $v0 - Result of the multiplication
# Side effects: None

.text
Mult4:
    sll $v0, $a0, 2    # Shift left by 2 to multiply by 4
    jr $ra
    
# Subprogram: Swap
# Author: Charles Kann
# Purpose: Swap two input parameters using the XOR operation
# Input: $a0 - First input parameter
#        $a1 - Second input parameter
# Output: $a0 - First input parameter after swapping
#         $a1 - Second input parameter after swapping
# Side effects: None

.text
Swap:
    xor $a0, $a0, $a1    # Swap using XOR
    xor $a1, $a0, $a1    # Swap using XOR again
    xor $a0, $a0, $a1    # Swap using XOR once more
    jr $ra