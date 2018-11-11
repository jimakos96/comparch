# n->$a0 , n pointer to struct btp_node
# key-> $a1
# estw to index ->$v0  poy epistrefei h get_children_index  

bpt_lookup:	
	addi $sp,$sp,-4 #  push in the stack 
	move $t1,$a1 #  $t1=key 
	move $t0,$a0 #  $t0=n
	sw   $ra,4($sp) # save return address in stack
M1:	
	beq $t0,$zero,M2 # if (n==0) go to M2
	lw $a1,36($t0)	# n->nr_keys is the second argument of get_children_index
	move $a2,$t1    # key is the third argument of get_children_index
	move $a0,$t0    # n is the first argument of get_children_index
	jal get_children_index # calling  get_children_index
	
	lw $t5,40($t0)  # $t5=n->is_leaf  
	beq $t5,$zero,M3  # if $t5=0 go to M3
	
	
		# index=$v0 from calling get_children_index above  
	sll $t3,$v0,2  # add offset 4*index since keys is array of integers
	add $t3,$t0,$t3 # $t3=&(n->keys[index])
	lw  $t3,0($t3)	# $t3=n->keys[index]
	beq $t3,$t1,M4 	# if(n->keys[index]==key) go to M4 

M3:	addi $v0,$v0,4  # index=index+4
	sll  $v0,$v0,2	# index=4*index+16   ,16 gia na ftasei sto children[0] + offset poy yparxei logw akeraiwn
	add  $t4,$t0,$v0 # $t4=&(n->children[index])
	lw   $a0,0($t4)  #  $t4=n->children[index]
	j M1 # ret=bpt_lookup(n->children[index],key)  to argument sto key einai ston $a1
	
	
	
	
	
	
	
	
M4:	addi $v0,$zero,1 # ret=1  return ret	
	
	
	
	
	
	
	
	
M2:	move $v0,$zero # return 0
	j END
	
	
END:	lw $ra,4($sp) # load return address from stack
	addi $sp,$sp,4 # pop  the stack
	jr $ra 
	
