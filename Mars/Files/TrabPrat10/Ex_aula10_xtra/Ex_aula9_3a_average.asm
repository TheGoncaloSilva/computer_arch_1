	# A função average() calcula o valor médio de um array de reais codificados em formato 
	# vírgula flutuante, precisão dupla
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não devem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double average(double *array, int n) { 
				# Mapa de registos 
				# double array: $a0 (Ponteiro para um array)
				# um INTEIRO, logo recebe-se no registo $a0)
				# int n: $a1
				# i: $t0
				# &array[i]: $t1
				# double sum: $f0
				# array[i] / (double)n: $f2
				
	.data
zero:	.double 0.0
	.text
	.globl average
average:	
	move $t0,$a1		# int i = n;
	l.d $f0,zero		# double sum = 0.0;
for:	ble $t0,0,endf		# for(; i > 0; i--) {
	
	sll $t1,$t0,3		# $t1 = i << 3 (múltiplo de 8)
	addu $t1,$a0,$t1	# $t1 = &array[i]
	l.d $f2,-8($t1)		# $t2 = array[i-1]
	
	add.d $f0,$f0,$f2	# sum += array[i-1]; 
	
	addi $t0,$t0,-1		# i--;
	j for
endf:				# }
	mtc1 $a1,$f2		# $f2 = n
	cvt.d.w	$f2,$f2		# $f2 = (double) n
	div.d $f0,$f0,$f2	# return sum / (double)n;
	jr $ra			# Fim do programa
