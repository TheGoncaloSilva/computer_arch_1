	# A  função  seguinte  converte  um  valor  de  temperatura  em  graus  Fahrenheit  para  graus 
	# Celsius
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não devem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double f2c(double ft) {
				# Mapa de registos 
				# double ft: $f12
	.data
n1:	.double 5.0
n2:	.double 9.0
n3: 	.double 32.0
	.text
	.globl f2c
f2c:	
	l.d $f0,n1		# $f0 = 5.0
	l.d $f2,n2		# $f2 = 9.0
	div.d $f0,$f0,$f2	# $f0 = 5.0 / 9.0
	
	l.d $f2,n3		# $f2 = 32.0
	sub.d $f2,$f12,$f2	# $f2 = ft - 32.0
	
	mul.d $f0,$f0,$f2	# $f0 = (5.0 / 9.0 * (ft – 32.0))
				# return (5.0 / 9.0 * (ft – 32.0));	
	jr $ra			# Fim do programa