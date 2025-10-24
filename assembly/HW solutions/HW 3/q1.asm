# q1.asm
# Arshiya Salehi
# question 1

.data
prompt: .asciiz "Enter an integer: "
result: .asciiz "Bitwise complement: "

.text
.globl main

main:
    # Display a prompt for user input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read an integer from the user
    li $v0, 5
    syscall

    # Store the input value in register $t0
    move $t0, $v0

    # Perform the bitwise complement (NOT) operation
    xori $t0, $t0, 0xFFFF

    # Display the result
    li $v0, 4
    la $a0, result
    syscall

    # Display the result value in hexadecimal format
    li $v0, 34 # Print integer as hexadecimal
    move $a0, $t0
    syscall

    # Exit the program
    li $v0, 10
    syscall
   
