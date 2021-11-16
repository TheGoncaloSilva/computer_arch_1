	# Alterar de modo a aceder ao array com índices
				# Mapa de registos
				# array: $t0
				# pultimo:$t1
				# i: $t2
				# soma: $t3
				# array[i]: $t4
				# pos i + array: $t5
	.data
array:	.word 7692,23,5,234	# Guardar um endereço na memória para o array
				# 0x1e0c,0x17,0x5,0xEA
				# 4 posições cada, 4 números = 16 posições na memória
	.eqv PRINT_INT10,1
	.eqv SIZE,4
	.text
	.globl main
main: 	li $t3,0 		# soma = 0;
	li $t1,SIZE 		# pultimo = ultima posição do array
	sub $t1,$t1,1 		# $t1 = 3 (SIZE - 1) (tbm dá addi $t1,$t1,-1)
	sll $t1,$t1,2 		# ou "mul $t1,$t1,4" (para multiplicar por 4, por causa de ser address)
	la $t0,array 		# array = array; (Inicializar com a posição inicial)
	
	li $t2,0		# i = 0;
	
while: 	bgtu $t2,$t1,endw 	# while(p <= pultimo){ (Por causa de estarmos a trabalhar com ponteiros 
				# e valores em binários)
	add $t5,$t0,$t2		# endereço do array inicial + i
	lw $t4,0($t5) 		# $t4 = array + i; (lw para carregar a posição inteira)
	add $t3,$t3,$t4		# soma = soma + array[i];
	addiu $t2,$t2,4		# i++; (soma 4 por cada posição do array)
	
	j while
endw:	 			# }
	move $a0,$t3 		# $a0 = soma
	li $v0,PRINT_INT10	# opcode
	syscall			# rint_int10(soma);
	
	jr $ra 			# termina o programa
