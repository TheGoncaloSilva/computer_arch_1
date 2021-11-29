				# i : $t0
				# j: $t1
				# array[i][j]: $t3
	...
while:	
	la $t3,array # $t3 = &array[0]
	sll $t2,$t0,2 #
	addu $t3,$t3,$t2 # $t3 = &array[i]
	lw $t3,0($t3) # $t3 = array[i] = &array[i][0]
	addu $t3,$t3,$t1 # $t3 = &array[i][j]
	lb $t3,... # $t3 = array[i][j]
	...