# part1.s:  ECE 3504 Assembly file to confirm QtSPIM install w/ secret msg
# (this is the name of my program and matches file name) followed by description
# (this is my comment region to explain my work)
# NAME: 
# DATE: 
# PURPOSE:  Project 1, part 1 mystery message code. 
#           Run this program and submit my text file with my mystery response
#
# REGISTER USAGE:   (this is where we decsribe the semantics of values within registers)
#	s0: stores the integer input from the keyboard
#	a0: stores the address of the byte "mystery" (input parameter to syscall)
#	v0: syscall returns input values here
#
# ALGORITHM
#	(left for you to understand)
# (everything aove is for the human and is strictly readable text for the human to understand)

	# assembler directive to describe the "main" as a global label
	.globl main

	.data	# Data declaration section (Here is where variables and stored data exist)

mystery:	.byte		71	# Store some mysterious byte data
		.byte		111
		.byte		32
		.byte		72
		.byte		111
		.byte		107
		.byte		105
		.byte		101
		.byte		115
		.byte		33
		.byte		10
		.byte		0

	.text   # Text region - user instructions (your code)
	
main:		# Start of code section

	# all of your assembly code instructions go here
	la $a0, mystery		# load address of mystery into register
	addi $v0,$zero, 4	# (what does this do for syscall?)
	syscall				# make a syscall	
	
	# Exit gracefully w/ next 2 intructions using OS type system calls
	li $v0, 10
	syscall

# END OF PROGRAM part1.s