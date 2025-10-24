# HW 2 (extra credit)
# Arshiya Salehi
# Question 5

.data
promt: .asciiz "please type a string"
input: .space 100

.text
main:
la $a0, promt #loads the address of the promt
la $a1, input #loads address of the space
li $a2, 100   # the limit of user response
li $v0, 54   #syscall code for inputDialogBox
syscall

la $a0, input
li $a1, 1
li $v0, 55
syscall

li $v0,10
syscall