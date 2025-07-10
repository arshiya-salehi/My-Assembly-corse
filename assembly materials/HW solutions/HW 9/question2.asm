# File:		question2.asm
# Purpose:	To return a hexedicimal from a array
# Author: 	Arshiya Salehi
#
# Modification History
#	12/10/2023


.data
    a:     .word 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
    prompt_msg: .asciiz "Enter a number from 0 to 15: "
    result_msg: .asciiz "Your number is: "

.text
.globl main

main:
    # Display prompt message
    li $v0, 4           # Print string service code
    la $a0, prompt_msg  # Load address of prompt_msg
    syscall

    # Read an integer from the user
    li $v0, 5           # Read integer service code
    syscall
    move $t0, $v0       # Store the input in $t0

    # Check if the input is within the range [0, 15]
    li $t1, 15          # Load 15 into $t1 (upper bound)
    bgt $t0, $t1, out_of_range # Branch if input > 15
    li $t1, 0           # Load 0 into $t1 (lower bound)
    blt $t0, $t1, out_of_range # Branch if input < 0

    # Display the result
    li $v0, 4           # Print string service code
    la $a0, result_msg  # Load address of result_msg
    syscall

    # Load the hexadecimal digit from the array
    la $t2, a           # Load address of the array a
    sll $t0, $t0, 2     # Multiply input by 4 to get the offset
    add $t2, $t2, $t0   # Add offset to the base address
    lw $a0, 0($t2)      # Load the value from memory

    # Display the hexadecimal digit
    li $v0, 34           # Print integer service code
    syscall

    # Exit the program
    li $v0, 10          # Exit service code
    syscall

out_of_range:
    # Display an error message for out-of-range input
    li $v0, 4           # Print string service code
    la $a0, out_of_range_msg # Load address of out_of_range_msg
    syscall

    # Exit the program
    li $v0, 10          # Exit service code
    syscall

.data
    out_of_range_msg: .asciiz "Error: Input is out of range (0-15).\n"