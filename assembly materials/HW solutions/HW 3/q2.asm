# q1.asm
# Arshiya Salehi
# question 1


.data
prompt: .asciiz "Enter a number you want to negate: "
decimal_msg: .asciiz "Your answer in Decimal is: "
hex_msg: .asciiz "Answer in Hex format: "

.text
.globl main

main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read user input
    li $v0, 5
    syscall
    move $t0, $v0 # Store the input in $t0

    # Calculate two's complement
    li $t1, 0xffffffff # Load immediate with all 1's
    xor $t0, $t0, $t1 # Calculate 1's complement
    addi $t0, $t0, 1 # Add 1 to get 2's complement

    # Print result in decimal
    li $v0, 4
    la $a0, decimal_msg
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

    # Print result in hexadecimal
    li $v0, 4
    la $a0, hex_msg
    syscall
    li $v0, 34
    move $a0, $t0
    syscall

    # Exit
    li $v0, 10
    syscall