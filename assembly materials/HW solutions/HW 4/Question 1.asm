# Question 1.asm
# Arshiya Salehi
# question 1

.text
.globl main
main:

li $v0, 4
la $a0 , result
syscall

ori $t0, $zero, 15
ori $t1, $zero, 3
add $t1, $zero $t1
sub $t2, $t0, $t1
sra $t2, $t2, 2
mult $t0, $t1
mflo $a0
ori $v0, $zero, 1
syscall
addi $v0, $zero, 10
syscall 


.data
result: .asciiz "15 * 3 is  

#====================answer for output 45========================
# 0x3408000f   
# 0x34090003
# 0x00094820
# 0x01095022
# 0x000a5083 
# 0x01090018 
# 0x00002012
# 0x34020001
# 0x0000000c
# 0x2002000a
# 0x0000000c 
#==================answer for output 15 *3 is 45=================
# 0x24020004
# 0x3c011001
# 0x34240000
# 000000000c
# 0x3408000f   
# 0x34090003
# 0x00094820
# 0x01095022
# 0x000a5083 
# 0x01090018 
# 0x00002012
# 0x34020001
# 0x0000000c
# 0x2002000a
# 0x0000000c 