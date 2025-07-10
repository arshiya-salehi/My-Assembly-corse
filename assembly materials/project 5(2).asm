.data
prompt: .asciiz "Enter a number: "
result_msg: .asciiz "Sum of numbers from 1 to "
newline: .asciiz "\n"

.text
main:
    # Display prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read input (n) from the user
    li $v0, 5
    syscall
    move $a0, $v0

    # Call the recursive function
    jal sumOfNumbers

    # Display result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Display the result
    move $a0, $v0
    li $v0, 1
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall

sumOfNumbers:
    # Recursive function to calculate the sum of numbers from 1 to n
    # Input: $a0 - n
    # Output: $v0 - sum

    # Base case: if n == 0, return 0
    beq $a0, $zero, base_case

    # Save return address and $a0 on the stack
    sub $sp, $sp, 8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    # n + sumOfNumbers(n-1)
    sub $a0, $a0, 1
    jal sumOfNumbers
    lw $ra, 4($sp)
    lw $a0, 0($sp)
    add $sp, $sp, 8
    add $v0, $a0, $v0

    jr $ra

base_case:
    # Base case: n == 0, return 0
    li $v0, 0
    jr $ra
