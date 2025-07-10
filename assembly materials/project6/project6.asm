# File:	project6.asm
# Purpose:	use selection sort to sort an array
# Author:	Arshiya Salehi
# 
# Subprograms Index:
#
#   SelectionSort	sort the array given to it
#   PrintIntArray	print the array	
#
# Modification History
#     12/20/2023 - Initial release


.data
array:  .word 4,8,2,13,3,7
n:      .word 6

.text
main:

    la $a0, array    
    lw $a1, n
    jal PrintIntArray

    la $a0, array    # Load base address of the array
    lw $a1, n        # Load the number of elements in the array
    jal SelectionSort
    
    jal PrintNewLine
    
    la $a0, array    
    lw $a1, n        
    jal PrintIntArray
    
    jal Exit

# Subprogram:	SelectionSort
# Purpose: 	sort the data uding selection sort algoritm
# Input Params: $a0-array
#		$a1- size of array
# Register conventions:
#	$0 - array base
#	$s1 - array size
#	$s2 - outer loop counter
#	$s3 - inner loop counter
 
.text
SelectionSort:
    addi $sp, $sp, -20    # save stack information
    sw $ra, 0($sp)        # save return address
    sw $s0, 4($sp)        # save $s0
    sw $s1, 8($sp)        # save $s1
    sw $s2, 12($sp)       # save $s2
    sw $s3, 16($sp)       # save $s3

    move $s0, $a0         # $s0 = array
    move $s1, $a1         # $s1 = array size
    addi $s1, $s1, 1

    addi $s2, $zero, 0    # outer loop counter
OuterLoop:
    addi $t1, $s1, 0
    slt $t0, $s2, $t1
    beqz $t0, EndOuterLoop

    addi $s3, $s2, 1      # start with the next element as the minimum
    move $t4, $s2         # $t4 = minIndex

    # Inner loop to find the index of the minimum element
InnerLoop:
    addi $t1, $s1, -1
    slt $t0, $s3, $t1
    beqz $t0, EndInnerLoop

    sll $t5, $s3, 2       # load data[j]. Note offset is 4 bytes
    add $t5, $s0, $t5
    lw $t2, 0($t5)        # $t2 = data[j]

    sll $t6, $t4, 2       # load data[minIndex]
    add $t6, $s0, $t6
    lw $t3, 0($t6)        # $t3 = data[minIndex]

    sgt $t0, $t3, $t2
    beqz $t0, NotSmaller

    # Update minIndex
    move $t4, $s3

NotSmaller:
    addi $s3, $s3, 1
    j InnerLoop

EndInnerLoop:
    # Swap elements at $s2 and $t4
    move $a0, $s0          # array
    move $a1, $s2          # index1
    move $a2, $t4          # index2
    jal Swap

    addi $s2, $s2, 1       # increment outer loop counter
    j OuterLoop

EndOuterLoop:
    lw $ra, 0($sp)         # restore return address
    lw $s0, 4($sp)         # restore $s0
    lw $s1, 8($sp)         # restore $s1
    lw $s2, 12($sp)        # restore $s2
    lw $s3, 16($sp)        # restore $s3
    addi $sp, $sp, 20      # restore stack
    jr $ra                 # return

# subprogram:	swap
# purpose:	to swap values in an array of integers
# input parameters: 
#		$a0 - the array containing elemets to swap
#		$a1 - index of element 1
#		$a2 - index of element 2
# Side Effects:		array is changed to swap element 1 and element 2
Swap: 
sll $t0, $a1, 2
add $t0, $a0, $t0 
sll $t1, $a2, 2
add $t1, $a0, $t1 
lw $t2, 0($t0)
lw $t3, 0($t1) 
sw $t2, 0($t1) 
sw $t3, 0($t0)
jr $ra

.text
PrintIntArray: 
addi $sp, $sp, -16
sw $ra, 0($sp) 
sw $s0, 4($sp) 
sw $s1, 8($sp)
sw $s2, 12($sp)

move $s0, $a0

move $s1, $a1 
move $s2, $zero

la $a0, open_bracket 
jal PrintString

loop: # check ending condition 
sge $t0, $s2, $s1 
bnez $t0, end_loop
sll $t0, $s2, 2

add $t0, $t0, $s0 
lw $a1, 0($t0)
la $a0, comma 
jal PrintInt
addi $s2, $s2, 1
b loop

end_loop: 
li $v0, 4
la $a0, close_bracket 
syscall

lw $ra, 0($sp) 
lw $s0, 4($sp) 
lw $s1, 8($sp) 
lw $s2, 12($sp)
addi $sp, $sp, 16 
jr $ra


.include "utils.asm"