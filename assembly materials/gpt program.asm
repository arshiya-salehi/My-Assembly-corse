.data
array:  .word 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
n:      .word 11  # Number of elements in the array
result: .asciiz "Sum: "

.text
main:
    la $t0, array   # Load base address of the array into $t0
    lw $t1, n       # Load the number of elements into $t1
    li $t2, 0       # Initialize sum to 0

    loop:
        lw $t3, 0($t0)   # Load the current element into $t3
        add $t2, $t2, $t3 # Add the current element to sum
        addi $t0, $t0, 4  # Move to the next element in the array
        addi $t1, $t1, -1 # Decrement the counter
        bnez $t1, loop    # Branch back to loop if counter is not zero

    # Print the result
    li $v0, 4         # System call code for print_str
    la $a0, result    # Load the address of the string to be printed
    syscall

    li $v0, 1         # System call code for print_int
    move $a0, $t2     # Load the sum to be printed
    syscall

    # Exit program
    li $v0, 10       # System call code for exit
    syscall
