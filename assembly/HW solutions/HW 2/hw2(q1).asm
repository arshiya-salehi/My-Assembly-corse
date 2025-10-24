# HW chapter 2 
# Arshiya Salehi
# question 1

.text
main:
li $v0, 4
la $a0, promt
syscall

li $v0, 8
la $a0,input
lw $a1, inputSize
syscall

li $v0, 4
la $a0,result1
syscall

li $v0, 4
la $a0, input
syscall

li $v0, 4
la $a0, result2
syscall

li $v0, 10
syscall

.data
promt: .asciiz "what is your favorite pie?\n"
input: .space 81  # it would save 80 char
inputSize: .word 80 
result1: .asciiz "So you like "
result2: .asciiz "pie."

# due to reading the enter as an asci character when we enter it and then when you want to output it
# it would also save the asci charaterrs to our input as well
