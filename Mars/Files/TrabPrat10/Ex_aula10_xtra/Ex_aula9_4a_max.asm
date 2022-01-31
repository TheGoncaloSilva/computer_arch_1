	# A função max() calcula o valor máximo de um array de "n" elementos em formato vírgula 
	# flutuante, precisão dupla. 
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não devem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double max(double *p, unsigned int n) { 
				# Mapa de registos 
				# double *p: $a0
				# int n: $a1
				# double max: $f0
				# double *u: $t0
	.data
	.text
	.globl max
max:	
	addiu $t0,$a1,-1	# n -= 1;
	sll $t0,$t0,3		# $t0 = n << 3
	addu $t0,$t0,$a0	# $t0 = p + (n-1)
	l.d $f0,0($a0)		# max = *p
	addiu $a0,$a0,8		# p++;

for:	bgtu $a0,$t0,endf	# for(; p <= u; p++) {

 	l.d $f2,0($a0)		# $f2 = *p
if:	c.le.d $f2,$f0		# if(*p > max)
	bc1t endif		# {
	mov.d $f0,$f2		# max = *p; 
endif:				# } 
 	addiu $a0,$a0,8		# p++;
	j for
endf:				# }
				# return max;
	jr $ra			# Fim do programa
