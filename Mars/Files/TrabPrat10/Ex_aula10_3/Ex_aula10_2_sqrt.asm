	# A função sqrt implementa um algoritmo de cálculo da raiz quadrada (conhecido como
	# "Babylonian method")
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não podem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double sqrt(double val) {
				# Mapa de registos:
				# val: $f12
				# aux: $f0
				# xn: $f2
				# zero: $f4
				# i: $t0
	.data
n1:	.double 1.0
n2:	.double 0.5
zero:	.double 0.0
	.text
	.globl sqrt
sqrt:	
	l.d $f2,n1		# xn = 1.0;
	li $t0,0		# i = 0;
	
	l.d $f4,zero		# $f4 = 0.0
if:	c.le.d $f12,$f4		# if(val > 0.0)
	bc1t else		# {
do:				# do {
	mov.d $f0,$f2		# aux = xn;
	
	div.d $f8,$f12,$f2	# $f8 = val/xn;
	add.d $f8,$f2,$f8	# $f8 = xn + val/xn;	
	l.d $f6,n2		# $f6 = 0.5;			
	mul.d $f2,$f6,$f8	# xn = 0.5 * (xn + val/xn);

	addi $t0,$t0,1		# i++;
	c.eq.d $f0,$f2
	bc1t endw
while:	blt $t0,25,do		# } while((aux != xn) && (++i < 25));
endw:		
	j endif
else:				# } else {
	l.d $f2,zero		# xn = 0.0;
endif:				# }

	mov.d $f0,$f2		# return xn;
	jr $ra			# Fim do programa
				
	