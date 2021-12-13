	# O argumento da fun��o � passado em $a0 e $a1
	# Sub-rotina terminal: n�o devem ser usados registos $sx
	# Fun��o do tipo void, sem retorno
				# Mapa de registos:
				# aux: $t0
				# *c1: $a0
				# *c2: $a1
	.text
	.globl exchange
exchange:	
	lb $t0,0($a0)		# char aux = *c1;
	lb $t1,0($a1)		# $t1 = *c2
	sb $t1,0($a0)		# *c1 = *c2; 
	sb $t0,0($a1)		# *c2 = aux;
	jr $ra			# Fim da fun��o exchange