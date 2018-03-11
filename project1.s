# First SPIM Assignment
	# Program 1
	# Name: Kyler Ferrell-Clegg
	# Class: CDA3101 - 6692
	# Date: 9/18/2017
# Start with data declarations
#
	.data 
out1: .asciiz "Index of the largest number: "					# 1st output string
out2: .asciiz "The largest number: "							# 2nd output string
newline: .asciiz "\n"  											# This will cause the screen cursor to move to a newline
arrayA: .word 89, 19, 91, 23, 31, 96, 3, 67, 17, 11, 43, 75		# Initialize an array with 12 possible values and all default values of 0
.align 2

.globl main			# leave this here for the moment
.text			    # This is an I/O sequence. Print the string 
	
main: 
	la $s4, arrayA			# We assign $s4 to arrayA address
	
	addi $s0, $zero, 0		# int max = 0;
	addi $s1, $zero, 0		# int maxIndex = 0; 
	addi $s2, $zero, 0		# int i = 0; 
	
	STARTLOOP:
	addi $s3, $s2, -12
	bgez $s3, ENDLOOP		# Ends the loop if/when i >= 12
	
	add $s5, $s2, $s2		# 2x index
	add $s5, $s5, $s5		# 4x index, every 4 bytes is the next value in arrayA
	add $s6, $s4, $s5		# computes the array indexing correctly
	
	lw $s7, 0($s6)			# load word of index i of arrayA
	
	slt $t1, $s0, $s7			# does comparison of $s7 > $s0 
	move $t2, $s2
	addi $s2, $s2, 1			# increments i by 1
	beq $t1, $zero, STARTLOOP	# if $s7 < $s0 then, go back to start of the loop
	
	move $s0, $s7			# else then, set $s0 = $s7 & set $s1 = $s2
	move $s1, $t2			
	
	j STARTLOOP
	ENDLOOP:
	
	# Print out the index of the largest value
	
	la $a0, out1		# Load address of out1 into register $a0
	li $v0, 4			# Load I/O code to print string to console
	syscall				# print string

	li $v0, 1			# an I/O sequence to write an integer from the console window
	move $a0, $s1		# $s1 is the register holding the index of the largest number
	syscall 
	
	# Print a single newline
	
	la $a0, newline		# Load address of newline 
	li $v0, 4			# Load I/O code to print string to console
	syscall 

	# Print out the largest value
	
	la $a0, out2		# Load address of out2 into register $a0
	li $v0, 4			# Load I/O code to print string to console
	syscall				# print string

	li $v0, 1			# an I/O sequence to write an integer from the console window
	move $a0, $s0		# $s0 is the register holding the largest number
	syscall 

	
	li $v0, 10		# syscall code 10 for terminating the program
	syscall