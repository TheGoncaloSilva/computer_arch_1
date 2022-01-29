	# Habilitar "assemble all files in directory" setting
	# Sub-rotina Terminal: Não usar registos $sx ou $f20...	
	# float f2(void) {			
				# Mapa de registos:
	.data
uvw:	.space 40		# Reservar espaço para a struct uvw
n1:	.double 3.141592653589
n2:	.float 1.983
str1:	.asciiz "St1"
	.text
	.globl f2
f2:
	la $t0,uvw		# uvw s2;
	la $t1,str1
	sw $t1,0($t0)		# s2 -> a1
	
	l.d $f0,n1
	s.d $f0,16($t0)		# s2 -> g
	
	li $t5,291
	sw $t5,24($t0)		# s2 -> a2[0]
	
	li $t5,756
	sw $t5,28($t0)		# s2 -> a2[1]
	
	li $t5,'X'
	sb $t5,32($t0)		# s2 -> v
	
	l.s $f2,n2
	s.s $f2,36($t0)		# s2 -> k
	
	l.d $f0,16($t0)		# $f0 = s2.g
	cvt.s.d $f0,$f0		# float ($f0)
	
	l.s $f2,28($t0)		# $f2 = s2.a2[1]
	l.s $f4,n2		# $f4 = k
	
	mul.s $f0,$f0,$f2 	# $f0 = s2.g * s2.a2[1]
	div.s $f0,$f0,$f4	# return (s2.g * s2.a2[1]) / k

	jr $ra			# Fim da função f2