				# Mapa de registos
				# p (= &array): $t0
				# pultimo:$t1
				# *p $t2
				# soma: $t3
	.data
array:	.word 7692,23,5,234	# Guardar um endere�o na mem�ria para o array
				# 0x1e0c,0x17,0x5,0xEA
				# 4 posi��es cada, 4 n�meros = 16 posi��es na mem�ria
	.eqv PRINT_INT10,1
	.eqv SIZE,4
	.text
	.globl main
main: 	li $t3,0 		# soma = 0;
	li $t4,SIZE 		#
	sub $t4,$t4,1 		# $t4 = 3 (SIZE - 1) (tbm d� addi $t4,$t4,-1)
	sll $t4,$t4,2 		# ou "mul $t4,$t4,4" (para multiplicar por 4, por causa de ser address)
	la $t0,array 		# p = array; (Inicializar com a posi��o inicial)
	addu $t1,$t0,$t4 	# pultimo = array + SIZE - 1;
	
while: 				#
	bgtu $t0,$t1,endw 	# while(p <= pultimo){ (Por causa de estarmos a trabalhar com ponteiros 
				# e valores em bin�rios)
	lw $t2,0($t0) 		# $t2 = *p; (lw para carregar a posi��o inteira)
	add $t3,$t3,$t2		# soma = soma + (*p);
	addiu $t0,$t0,4 	# p++; (soma 4 por cada posi��o do array)
	
	j while
endw:	 			# }
	move $a0,$t3 		# $a0 = soma
	li $v0,PRINT_INT10	# opcode
	syscall			# rint_int10(soma);
	
	jr $ra 			# termina o programa
