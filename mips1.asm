1h Askisi
#Kosyvas Dimitrios
#03114828


# $s0->base address of A
# $S1->pointer to addrees of array[8]
# $s2->N 

	addi $s1,$s0,32 	# $s1 points to array[8]
LOOP:	lw $t0,0($s1)  		# dereference of $s1 to $t0 ($t0=*p)
	beq $t0,$zero,END 	#if (*p==0) go to END
	div $t0,$s2  		#division $t0 by $s2 
	slt $t1,$t0,100  	# if $t0<100  $t1=1
	beq $t1,$zero,ELSE  	#if  $t1=0 go to ELSE
	mfhi $t0   		# remainder of division goes to $t0
	jmp NEXT
ELSE:	mflo $t0		#the quotient of division goes to $t0
NEXT:	sw $t0,0($s1)	# write new value to the index that the pointer points to
	addi $s1,$s1,4		#increase address of pointer by 4
	jmp LOOP
END: 

