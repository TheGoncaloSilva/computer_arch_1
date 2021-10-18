	.data
				# nada a colocar aqui, de momento
	.text
	.globl main
main: 	ori $t0,$0,2 	# $t0 = x (substituir val_x pelo
				# valor de x pretendido)
	ori $t2,$0,8 		# $t2 = 8 (Ori guarda o valor numa constante, ou carrega no registo)
	add $t1,$t0,$t0 	# $t1 = $t0 + $t0 = x + x = 2 * x
	#add $t1,$t1,$t2 	# $t1 = $t1 + $t2 = y = 2 * x + 8
	sub $t1,$t1,$t2 	# $t1 = $t1 - $t2 = y = 2 * x - 8
	add $t3, $t1, $zero	# $t3 = $t1 (with)
	or $t4, $t1, $zero	# $t4 = $t1 (add)
	move $t5, $t1		# $t5 = $t1 (move) (Não é nativo, o assembler usa o OR)
	jr $ra 			# fim do programa
