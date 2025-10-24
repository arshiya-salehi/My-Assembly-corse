.data
a:      .asciiz "0x0"
        .asciiz "0x1"
        .asciiz "0x2"
        .asciiz "0x3"
        .asciiz "0x4"
        .asciiz "0x5"
        .asciiz "0x6"
        .asciiz "0x7"
        .asciiz "0x8"
        .asciiz "0x9"
        .asciiz "0xa"
        .asciiz "0xb"
        .asciiz "0xc"
        .asciiz "0xd"
        .asciiz "0xe"
        .asciiz "0xf"

.text
main:
        # Prompt user for input
        li $v0, 4           # System call for print_str
        la $a0, prompt_msg  # Load prompt message address
        syscall

        li $v0, 5           # System call for read_int
        syscall
        move $t0, $v0       # Save the user input in $t0

        # Check if input is within the valid range [0, 15]
        li $t1, 0
        li $t2, 15
        blt $t0, $t1, invalid_input
        bgt $t0, $t2, invalid_input

        # Print the result
        li $v0, 4           # System call for print_str
        la $a0, result_msg  # Load result message address
        syscall

        # Print the corresponding hexadecimal digit
        move $a0, $t0       # Load the user input into $a0
        li $v0, 4           # System call for print_str
        syscall

        # Exit program
        li $v0, 10          # System call for exit
        syscall

invalid_input:
        # Print error message for invalid input
        li $v0, 4           # System call for print_str
        la $a0, error_msg   # Load error message address
        syscall

        # Exit program
        li $v0, 10          # System call for exit
        syscall

.data
# Data section
prompt_msg:     .asciiz "Enter a number from 0 to 15: "
result_msg:     .asciiz "Your number is 0x"
error_msg:      .asciiz "Invalid input. Please enter a number from 0 to 15."
