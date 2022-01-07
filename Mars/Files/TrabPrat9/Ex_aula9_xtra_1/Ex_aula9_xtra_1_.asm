	# A função median calcula a mediana dos valores de um array de reais
	# codificado em precisão dupla
	# Sub rotina terminal, não usar os registos $sx.
	# Habilitar "assemble all files in directory" setting
	# double median(double *array, int nval) {
				# Mapa de registos:
				# *array: $a0
				# nval: $a1
				# houveTroca: $t0
				# i: $t1
				# double aux: $f0
	.eqv TRUE,1
	.eqv FALSE,0
	.text
	.globl median
median:
	
	
	
	jr $ra			# Fim do programa
