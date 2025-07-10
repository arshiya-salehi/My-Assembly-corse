# Filename: project 4.asm
# Author:  Arshiya Salehi
# Date:	11/26/2023
# Purpose:  print every other letter of alphabet in capital
# Modification Log:
#	11/26/2023 - Initial release
#
# Pseudo Code
# global main() {
#    // Print header
#    print(Every other capital letter of the alphabet:\n)
#
#    // counter loop from 65 to 90 in ascii table
#    for (char letter = 'A'; letter <= 'Z'; letter += 2) {
#        // Print the current character
#        print(letter + " ")
#    }
#}

.data
output_str: .asciiz "\nEvery other capital letter of the alphabet:\n"
    
.text
.globl main
    
main:
    # Print the header
    li $v0, 4           # syscall code for print_str
    la $a0, output_str  # load address of the string to be printed
    syscall
    
    # Print every other capital letter
    li $t0, 'A'         # ASCII value of 'A'
    li $t1, 'Z'         # ASCII value of 'Z'

print_loop:
    bgt $t0, $t1, end_program   # if t0 > t1, exit the loop
    
    # Print the current character
    li $v0, 11          # syscall code for print_char
    move $a0, $t0       # load the current character
    syscall
    
    # Print a space after each character
    li $v0, 11          # syscall code for print_char
    li $a0, ' '         # load the ASCII value of space
    syscall
    
    # Move to the next character
    addi $t0, $t0, 2
    
    j print_loop        # jump back to the beginning of the loop
    
end_program:
    # Exit program
    li $v0, 10          # syscall code for exit
    syscall
