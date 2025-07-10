# Homework 2
# Arshiya Salehi
# Question 2


.text
main:
li $v0, 31
li $a0, 60
li $a1, 1000
li $a2, 6
li $a3, 127
syscall

li $v0, 10
syscall


# they are service 31 and 32
# 31: will generate the tone then immediately return.
# 33: will generate the tone then sleep for the tone's duration before returning
