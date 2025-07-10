# project1.asm
# Arshiya Salehi
# project 1

.data
askN: .asciiz "Enter n: "
askT: .asciiz "Enter T: "
askP: .asciiz "Enter P:"
result: .asciiz "result is: "

.text
main:

li $v0, 4 # ask n
la $a0, askN # promt
syscall
li $v0, 5 # read n
syscall 
move $t0 , $v0 # save it to $t0

li $v0, 4 #ask T
la $a0, askT #promt
syscall
li $v0, 5 # read
syscall
move $t1, $v0 # save it to $t1

li $v0, 4 #ask P
la $a0, askP #promt
syscall
li $v0, 5 # read
syscall
move $t2, $v0 # save it to $t2

mult $t0, $t1
mflo $t4

div $t4,$t2
mflo $t5

# assign our const values
li $t0 8314
li $t6 1000

mult $t5, $t0
mflo $t8

div $t8,$t6  #binery: 000000 11000 011100000000000011010
mflo $t8

li $v0, 4 # ouput the promt 
la $a0, result
syscall

li $v0,1   # outputiting an intiger
move $a0,$t8 
syscall

li $v0, 10 # end
syscall
