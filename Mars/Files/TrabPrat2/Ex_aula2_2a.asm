	.data			# Zona de dados
	.asciiz "AC1, 21/22"	# Começa: 0x10010000
str1:	.asciiz "Outra Frase"	# COmeça: 0x10010011
	
	.text			# Zona de Código
	.globl main		# label global (visível a partir de outro código)
	.eqv shift_am, 4	# diretiva para subsituir a palavra 
				# shift_am por um valor
main: 	
	li $t0,0x862A5C1B 	# instrução virtual (decomposta
				# em duas instruções nativas)
	sll $t2,$t0,shift_am 	#
	srl $t3,$t0,shift_am 	#	
	sra $t4,$t0,shift_am 	#
				# Alínea C - Código de Gray
	ori $t5,$0,2		# $t5 = val_1
	srl $t6,$t5,1		# $t6 = $t5 >> 1 (shilft right logical)
				# Entra 0 do lado esquerdo
				# Alinea D - Gray -> Bin
	ori $t7,$0,2		# $t7 = gray
	or $t8,$0,$t7		# $t8 = $t7 -> num
	or $t9,$0,$8		# $t9 = $8
	
	srl $t9,$t9,4		# $t9 = $t9 >> 4
	xor $t8, $t8, $t9	# $t8 = $t8 ^ $t9 (xor)
	
	srl $t9,$t9,2		# $t9 = $t9 >> 2
	xor $t8, $t8, $t9	# $t8 = $t8 ^ $t9 (xor)
	
	srl $t9,$t9,1		# $t9 = $t9 >> 1
	xor $t8, $t8, $t9	# $t8 = $t8 ^ $t9 (xor)
		
	or $t9,$0,$t8		# $t9 = $t8 -> bin
	
							
	#ori $v0,$0,4		# Imprimir a String
	li $v0,4		# é igual ao comando acima
	li $a0, 0x10010000	# 
	la $a0, str1		# Descobrir e imprimir o address da str1
	syscall
	jr $ra 			# fim do programa