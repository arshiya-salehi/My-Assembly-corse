# File: HW8.asm
# Purpose: to find the the average and the largest number among 4 inputed intigers
# Authoer: Arshiya Salehi
#
# Subprogram Index:
# ifExit		exit the if satement
# largestAndAverage     find the largest number and calculate the average
# getLarger		find the larger number among 2 inputs
#
# Modification History
#	11/27/2023

.data
prompt1: .asciiz "\nEnter first value : "
prompt2: .asciiz "\nEnter second value : "
prompt3: .asciiz "\nEnter third value : "
prompt4: .asciiz "\nEnter fourth value : "
prompt5: .asciiz "\nThe largest is : "
prompt6: .asciiz "\nThe average is : "

.globl main
.text
main:

li $v0,4
la $a0,prompt1 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s0,$v0 #save a to t1

li $v0,4
la $a0,prompt2 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s1,$v0 #save a to t1

li $v0,4
la $a0,prompt3 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s2,$v0 #save a to t1


li $v0,4
la $a0,prompt4 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s3,$v0 #save a to t1

move $a0,$s0
move $a1,$s1
move $a2,$s2
move $a3,$s3
jal largestAndAverage

move $s3,$v0
move $s4,$v1


li $v0,4
la $a0,prompt5 #it will print prompt
syscall
li $v0,1
move $a0,$s3
syscall #print larger


li $v0,4
la $a0,prompt6 #it will print prompt
syscall
li $v0,1
move $a0,$s4
syscall #print larger

li $v0,10
syscall #terminate


# subprogram: largesAndAverage
# author: Arshiya Salehi
# purpose: get the average and also find the largest number using the larger subprogram
# Input: $a0,$a1,$a2,$a3 - the values that the user inputed
# Output: return the avearge and the largest number to 
# Side Effect: the values printed after the promt

largestAndAverage:
#get average
add $v1,$s0,$s1
add $v1,$v1,$s2
add $v1,$v1,$s3
div $v1,$v1,4 #get average

#calculate largest
move $s0,$a0
move $s1,$a1
move $s2,$a2
move $t7,$ra #get return address
move $a0,$s0
move $a1,$s1
jal getLarger #get largest between two
move $s3,$v0
move $a0,$s3
move $a1,$a2
jal getLarger #get largest among three

move $s3,$v0
move $a0,$s3
move $a1,$a3
jal getLarger #get largest among three

jr $t7 #back to caller

# subprogram: getLarger
# author: Arshiya Salehi
# purpose: find the larger number
# Input: $a0,$a1 - the value that are inputed from the previse subprogram
# Output: return the larger number
# Side Effect: reutrn only one number
getLarger:
move $v0,$a0
ble $a1,$a0,ifExit
move $v0,$a1 #get larger of the value

# subprogram: largesAndAverage
# author: Arshiya Salehi
# purpose: exit the if statment
# Input: none
# Output: none 
# Side Effect: the program exited
ifExit:
jr $ra
