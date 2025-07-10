# Program File: Program2-1.asm
# Author: Arshiya salehi
# Purpose: first program hello world
.data
greeting: .asciiz "hello world"

.text
main:
li $v0, 4
la $a0, greeting
syscall


li $v0, 10
syscall
 