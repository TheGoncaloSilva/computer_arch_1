				# Mapa de registos
				# n_even: $t0
				# n_odd: $t1
				# p1: $t2
				# *p1: $t3
				# p2: $t4
				# *p2: $t5
				# Temp1: $t6
				# Temp2: $t7
	.data
	.eqv N,35		# 
	.eqv READ_INT,5
	.eqv PRINT_INT10,1
arrA:	.space N		# Pôr manualmente este valor em ordem 2^x
arrB:	.space N
	.text
	.globl main
main:	
	li $t0,0		# n_even = 0;
	li $t1,0		# n_odd = 0;
	
	la $t2,arrA		# p1 = arrA
	addiu $t6,$t2,N		# Temp1 = a + N
for1:	
	bge $t2,$t6,endf1	# for( p1 = a; p1 < (a + N); p1++ ){
	
	li $v0,READ_INT
	syscall			# read_int();
	
	sw $v0,0($t2)		# *p1 = read_int();

	addiu $t2,$t2,4		# p1++;
	j for1
endf1:				# }
	la $t2,arrA		# p1 = arrA
	la $t4,arrB		# p2 = arrB
	addiu $t6,$t2,N		# Temp1 = a + N
for2:	
	bge $t2,$t6,endf2	# for( p1 = a; p2 = b; p1 < (a + N); p1++){
	
	lw $t3,0($t2)
if:	remu $t7,$t3,2		# Temp2 = (*p1 % 2)
	beq $t7,0,else		# if( (*p1 % 2) != 0 ){
	sw $t3,0($t4)		# p2 = *p1                           <= ERRO NESTE
	addiu $t4,$t4,4		# p2++ 
	addi $t1,$t1,1		# n_odd++;
	j endif
else:				# } else {
	addi $t0,$t0,1		# n_even++;
endif:				# }
	addiu $t2,$t2,4		# p1++;
	j for2
endf2:				# }
	la $t4,arrB		# p2 = arrB
	sll $t7,$t1,2		# Temp2 = n_odd << 2 ou "mul $t4,$t4,4" (para multiplicar por 4, por causa de ser address)
	addu $t6,$t4,$t7	# Temp1 = b + n_odd
for3:	
	bge $t4,$t6,endf3	# for( p2 = b; p2 < (b + n_odd); p2++){
	lw $t5,0($t4)		# *p2 = arrA[p2]
	move $a0,$t5
	li $v0,PRINT_INT10
	syscall			# print_int10( *p2 )
	
	addiu $t4,$t4,4		# p2++;
	j for3
endf3:				# }
	jr $ra			# Fim do programa