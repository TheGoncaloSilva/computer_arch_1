	# A função var cálcula a variância
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina intermédia: podem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double stdev(double *array, int nval) {
				# Mapa de registos:
				# *array: $a0
				# nval: $a1
	.text
	.globl stdev
stdev:	
	addiu $sp,$sp,-4	# Salvaguardar espaço na stack
	sw $ra,0($sp)		# guardar $ra
	
	jal var			# $f0 = var(array, nval);
	mov.d $f12,$f0		# $f12 = $f0
	jal sqrt		# return sqrt( var(array, nval) );
	
	lw $ra,0($sp)		# repor $ra
	addiu $sp,$sp,4		# libertar a stack		
	jr $ra			# Fim da função stdev
