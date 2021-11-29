				# p : $t1
				# pultimo: $t2
	...
	la $t1,array # $t1 = p = &array[0] = array
	li $t0,SIZE #
	sll $t0,$t0,2 #
	addu $t2,... # $t2 = pultimo = array + SIZE
for: 	...