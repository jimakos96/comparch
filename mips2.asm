2h Askisi
# s -> $a0 , s pointer to struct S 
# i -> $t0   
# a -> $t1 
# b -> $t2 
# c -> $t3 
# d -> $t4

foo:
	add $t0,$zero,$zero # i=0
	add $t2,$zero,$zero # b=0
	add $t3,$zero,$zero # c=0
	lui $t1,0xdead      # a=0xdead0000000.
	ori $t1,0xbeef	    #  a=0xdeadbeef
	addi $t4,$a0,24   #d=s->D[1] copy address of s->D[1] to the pointer d 
	
LOOP1: 	slti $t5,$t0,2      #   if i<2 $t5=1 else $t5=0
	beq  $t5,$zero,END1 #  if $t5=0 go out of the loop1
	sll  $t6,$t0,2 	    #add offset  4*i  since A is an array of integers
	add  $t6,$t6,$a0    #$t6=&(s->A[i])
	lw   $t6,0($t6)	     # $t6=s->A[i]
	add  $t1,$t1,$t6      # a+= s->A[i]
	addi $t0,$t0,1    #  i++
	j LOOP1

END1:	add $t0,$zero,$zero  # i=0

LOOP2:	slti $t5,$t0,8  #   if i<8 $t5=1 else $t5=0
	beq  $t5,$zero,END2 # $t5=0 go out of loop2
	addi  $t6,$a0,8		#$t6=&(s->B[0])
	add $t6,$t6,$t0         # $t6=&(s->B[i])   no need to add offest  B[i] array of chars 
	lb  $t6,0($t6)    	#$t6=s->B[i]	
	add $t2,$t2,$t6		#b+=s->B[i]
	add $t0,$t0,1 		#i++
	j LOOP2

END2: 	add $t0,$zero,$zero   #i=0

LOOP3:	slti $t5,$t0,2 		#   if i<2 $t5=1 else $t5=0
	beq  $t5,$zero,END3
	sll  $t7,$t0,1		#add offset 2*i   since C is an array of short integers 
	add $t6,$a0,16		# $t6=&(s->C[0]) 
	add $t6,$t6,$t7		# $t6=&(s->C[i])
	lh  $t6,0($t6)		# $t6=s->C[i]
	add $t3,$t3,$t6		# c+=s->C[i]
	add $t0,$t0,1		# i++
	j LOOP3
END3:
	addi $t7,$zero,30  	# $t7=30
	div $t1,$t7		#  divide a by 30
	mfhi $t7		# $t7=a%30
	slti $t6,$t7,10		# if $t7<10 $t6=1 else $t6=0
	beq  $t6,$zero,Fin	#if $t6=0 go to fin
	mflo $t1		#a=a/30

Fin:	addi $t6,$a0,8		# $t6=&(s->B[0])
	sb   $t2,0($t6)		# (s->B[0])=b
	addi $t6,$a0,16		# $t6=&(s->C[0])
	sh   $t3,0($t6)		# (s->C[0])=c
	
	add $v0,$zero,$t1	#return a
	jr	$ra
		

			 
			 		 		 
	
			
		 
