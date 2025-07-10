# File:	Project 5.asm
# Purpuse: this program would add n numbers using recersuin
# Author:	Arshiya Salehi
#
# Subprograms Index:
# 	Exit		call syscall with a server 10 to exit the program
#	PrintInt	Print a string with an integer to the console
#	PromptInt	Prompt for an int & return it to the calling program 
#	function	this is our function witch would add all the numbers using recursion
#
# Modification History
#	12/3/2023 - Initial release

.data
	prompt: .asciiz "enter a number:"
	result: .asciiz  "result is:"
	
.text
main:

	la $a0, prompt
	jal PromptInt
	move $s0, $v0
	# s0 has the input
	
	move $a0, $s0
	jal function
	move $s1, $v0
	
	la $a0, result
	move $a1, $s1
	jal PrintInt
	
	jal Exit
	
	
# Subprogram:	PromptInt
# Author:	Arshiya Salehi
# Purpose:	to prompt the user for an integer, and to return that input value to the caller.
# Input:	$a0 - the address of hte string to print
# Output:	$v0 - the calue the user entered
# Side effects:	the string is printed followed by the integer value.
.text
PromptInt:
	li $v0, 4
	syscall
	
	move $a0, $a1
	li $v0, 5
	syscall
	
	jr $ra
	
# Subprogram:	PrintInt
# Author:	Arshiya Salehi
# Purpose:	To print a string to the console
# Input:	$a0 - The address of hte string to print.
#		$a1 - the value of the int to print
# Output:	None
#Side effects:	The String is printed followed by the integer value.

.text
PrintInt:
	li $v0, 4
	syscall
	
	move $a0, $a1
	li $v0, 1
	syscall
	
	jr $ra

# subprogram:	function
# Author:	Arshiya Salehi
# Purpuse:	calculate the numbers using recursion
# Input:	$a0 - the number inputed by user return to this subprogram
# Output:	$v0 - the sum of all numbers would be returned to this register and return to main
# side effects:	The answer would get calculated and return to the main

.text
function:
	addi $sp, $sp, -8 # save space on the stack for the $ra
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	
	seq $t0, $a0, $zero
	addi $v0, $zero, 0
	bnez $t0, Return
	
	addi $a0, $a0, -1
	jal function
	lw $a0, 4($sp)
	add $v0, $a0, $v0
	
	Return:
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra

# Subprogram:	Exit
# Author: 	Arshiya Salehi	
# Purpose: 	to use syscall service 10 to exit a program
# input/ouput:	None
# Side effects:	The program is exited

.text
Exit:
	li $v0, 10
	syscall
