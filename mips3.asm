# A->$a0
# N->$a1
# key->$a2
# i->$t0

get_children_index:	
	add $t0,$zero,$zero # i=0
	
LOOP:	slt $t3,$0,$a1 # if i<N  $t3=1 else $t3=0
	beq $t3,$zero,END
	
	
	sll $t2,$t0,2	# 4*i  add offset A is array of integers	
	add $t2,$t2,$a0	# $t2=&(A[i])
	lw  $t2,0($t2)	# $t2=A[i]
	slt $t3,$a2,$t2	# if key<A[i]  $t3=1 else $t3=0
	beq $t3,$zero,END
	addi $t0,$t0,1  # i++
	j LOOP
END:	add $v0,$zero,$t0 # return i	
	jr $ra
		
