.data
	n:	.word 5		# declare variable n with value of 5
.text
main:
	lw	$a0, n		# load n into $a0(argument1)
	
	#function call
	jal	fact		# jump and link to "fact", and store the address of next line into $ra(return address)
	move	$a0, $v0	# set $a0(argument1) with value of $v0
	
	#print result
	li	$v0, 1		# load immidiate $v0 with value 1 (Print integer)
	syscall			# issue a system call (Print argument1)
	
	#exit
	li	$v0, 10		# load immidiate $v0 with value 10 (Exit)
	syscall			# issue a system call (Exit)
	
fact:
	addi	$sp, $sp, -8	# adjust stack for 2 items
	sw	$ra, 4($sp)	# save the return address
	sw	$a0, 0($sp)	# save the argument n
	slti	$t0, $a0, 1	# test for n < 1
	beq	$t0, $zero, L1	# if n >= 1, go to L1
	addi	$v0, $zero, 1	# return 1
	addi	$sp, $sp, 8	# pop 2 items off stack
	jr	$ra		# return to the address line(according to $ra)
	
L1:
	addi	$a0, $a0, -1	# n >= 1: argument gets (n - 1)
	jal 	fact		# call fact with (n - 1), and store the address of next line into $ra(return address)
	lw	$a0, 0($sp)	# return from jal: restore argument n
	lw	$ra, 4($sp)	# resture the return address
	addi	$sp, $sp, 8	# adjust stack pointer to pop 2 items
	mul	$v0, $a0, $v0	# return n * fact (n - 1)
	jr	$ra		# return to the address line(according to $ra)
