# part4.s:  ECE 3504 Partial code to solve part5 of Project 1
# (this is the name of my program and matches file name) followed by description
# NAME: Hampton McGrath
# DATE: 02-Mar-22
# PURPOSE:  Project 1, part 5 code
#
# REGISTER USAGE:   (this is where we decsribe the semantics of values within registers)
#	s0: stores the integer input from the keyboard
#   s1: stores the value used to iterate the loops ($s1 = i)
#   s2: stores the end condition of the for loop
#   s3: stores the address used for storing values in memory
#
#	t0: used for swapping values in memory
#	t1: used for swapping the values in memory
#
#	a0: stores the address of prompt string (input_msg, or comma_space) (input parameter to syscall)
#	v0: syscall returns input values here
# 
#
# ALGORITHM
#	(left for you to understand)
#  (everything aove is for the human and is strictly readable text for the human to understand)

	# assembler directive to describe the "__start" as a global label
	.globl __start 

	.data	# Data declaration section (Here is where variables and stored data exist)

input_msg:		.asciiz		"Enter integers in order one at a time: "
error_msg: 		.asciiz     "No errors here"
comma_space:	.asciiz		", "
newline:		.asciiz		"\n"
DaValues:   .word        0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	.text   # Text region - user instructions (your code)

__start:	# execution starts here

    li $s2, 10          # load the end condition
    la $s3, DaValues    # load base address of DaValues into register

GET_LOOP:


	la $a0, input_msg   # load address of input msg into register
	li $v0, 4			# input_msg prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window

	# read integer into $a0
    li	$v0, 5		    # system call code for read integer = 5
    syscall			    # call operating system
	# value read from keyboard returned in register $v0
    
    sw $v0, 0($s3)
    addi $s3, $s3, 4

    bne $s2, $v0, GET_LOOP  # Branch to the beginning of the loop until the value entered is equal to ten

#########################################################
# Everything above this line is for setting up purposes
# The rest of the program is implemented below here
#########################################################

    li $s1, 0
    li $s2, 4
    la $s3, DaValues

PRINT_LOOP:

	lw $a0, 4($s3)		
    li $v0, 1			    # system call code for printing integer = 1
    syscall				    # call operating system to perform print

    la $a0, comma_space		# load address of comma_space into register
	li $v0, 4               # system call code for printing a string = 4
	syscall				    # make a syscall to print comma_space in console window
	

    addi $s3, $s3, 8        # skips the next value stored in memory
    addi $s1, $s1, 1        # iterates i by 1
    bne $s1, $s2, PRINT_LOOP    # as long as i != end condition branch to PRINT_LOOP

	lw $a0, 4($s3)		
    li $v0, 1			    # system call code for printing integer = 1
    syscall				    # call operating system to perform print

    la $a0, newline			# load address of newline into register
	li $v0, 4               # system call code for printing a string = 4
	syscall				    # make a syscall to print comma_space in console window


	la $s3, DaValues

	lw $t0,  0($s3)
	lw $t1, 36($s3)

	sw $t0, 36($s3)
	sw $t1,  0($s3)

	lw $t0,  4($s3)
	lw $t1, 32($s3)

	sw $t0, 32($s3)
	sw $t1,  4($s3)

	lw $t0,  8($s3)
	lw $t1, 28($s3)

	sw $t0, 28($s3)
	sw $t1,  8($s3)

	lw $t0, 24($s3)
	lw $t1, 12($s3)

	sw $t0, 12($s3)
	sw $t1, 24($s3)

	lw $t0, 20($s3)
	lw $t1, 16($s3)

	sw $t0, 16($s3)
	sw $t1, 20($s3)


    li $s1, 0
    li $s2, 4
    la $s3, DaValues
	
PRINT_LOOP2:

	lw $a0, 4($s3)		
    li $v0, 1			    # system call code for printing integer = 1
    syscall				    # call operating system to perform print

    la $a0, comma_space		# load address of comma_space into register
	li $v0, 4               # system call code for printing a string = 4
	syscall				    # make a syscall to print comma_space in console window
	

    addi $s3, $s3, 8        # skips the next value stored in memory
    addi $s1, $s1, 1        # iterates i by 1
    bne $s1, $s2, PRINT_LOOP2    # as long as i != end condition branch to PRINT_LOOP

	lw $a0, 4($s3)		
    li $v0, 1			    # system call code for printing integer = 1
    syscall				    # call operating system to perform print

    la $a0, newline			# load address of newline into register
	li $v0, 4               # system call code for printing a string = 4
	syscall				    # make a syscall to print comma_space in console window


	li $v0, 10               # system call code for end of program
	syscall				     # exit the program via syscall
	