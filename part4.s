# part4.s:  ECE 3504 Partial code to solve part4 of Project 1
# (this is the name of my program and matches file name) followed by description
# NAME: Hampton McGrath
# DATE: 02-Mar-22
# PURPOSE:  Project 1, part 4 code
#
# REGISTER USAGE:   (this is where we decsribe the semantics of values within registers)
#	a0: stores the integer input from the keyboard
#	a0: stores the address of prompt string (input_msg, error_msg, or result_msg) (input parameter to syscall)
#	v0: syscall returns input values here
# 
#   $a1: store the value of i
#   $a2: stores the value of y
#
# ALGORITHM
#	(left for you to understand)
#  (everything aove is for the human and is strictly readable text for the human to understand)

	# assembler directive to describe the "__start" as a global label
	.globl __start 

	.data	# Data declaration section (Here is where variables and stored data exist)

input_msg:	.asciiz		"Enter an integer  between 1 and 9: "
error_msg:  .asciiz     "Error: input is out of range"
result_msg:	.asciiz		"The result of summation:   "

	.text   # Text region - user instructions (your code)

__start:	# execution starts here
			
	la $a0, input_msg   # load address of input msg into register
	li $v0, 4			# msg1 prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window

	# read integer into $a0
    li	$v0, 5		    # system call code for read integer = 5
    syscall			    # call operating system
	# value read from keyboard returned in register $v0
    add $a0, $zero, $v0	# move $v0 to $a0


#########################################################
# Everything above this line is for setting up purposes
# The rest of the program is implemented below here
#########################################################


    slti $t0, $a0, 1        # check if x is less than 1 
    bne $t0, $zero, ERROR   # if less than one print the error message

    slti $t0, $a0, 10       # check if the value is less than 10
    beq $t0, $zero, ERROR   # if greater than or equal to 10 print error message

    li $a1, 0               # initialize i to 0

	jal REC_FUNC


RESULT:
	la $a0, result_msg		# load address of result_msg into register
	li $v0, 4               # system call code for printing a string = 4
	syscall				    # make a syscall to print result_msg in console window
			
    li	$v0, 1			    # system call code for printing integer = 1
    move $a0, $a2	        # move integer to be printed into $a0:  $a0 = $t0
    syscall				    # call operating system to perform print

	li $v0, 10
	syscall			        # exit the program via syscall		

REC_FUNC:  

	addi $sp, $sp, -8		# set the stack pointer
	sw $ra, 0($sp)			# store the return address
	sw $a1, 4($sp)			# store the value of i
    bne $a1, $a0, ELSE      # if i is equal to x go to the if segment
    
IF: 
	add $a2, $zero, $a1 	# add i to the return value
	lw $ra, 0($sp)			# load the return address
	lw $a1, 4($sp)			# load the value of i
	addi $sp, $sp, 8		# restore the stack pointer
	jr $ra					# jump to the return address

ELSE: 
	addi $a1, $a1, 1		# increment i
    jal REC_FUNC			# call the recursive function
	lw $a1, 4($sp)			# load the stored value of i into $a1
	add $a2, $a1, $a2		# add the value of i to the return value
	lw $ra, 0($sp)			# load the return address into $ra
	addi $sp, $sp, 8		# restore the stack pointer
	jr $ra					# jump to the return address




ERROR:
	la $a0, error_msg		# load address of result_msg into register
	li $v0, 4               # system call code for printing a string = 4
	syscall				    # make a syscall to print result_msg in console window

	li $v0, 10
	syscall			        # exit the program via syscall		
