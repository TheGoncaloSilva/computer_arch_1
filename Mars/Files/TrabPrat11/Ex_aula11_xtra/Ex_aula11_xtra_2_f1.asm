	# Habilitar "assemble all files in directory" setting
	# Sub-rotina Terminal: Não usar registos $sx ou $f20...	
	# double f1(void) {		
				# Mapa de registos:
	.data
xyz:	.space 48		# Reservar espcaço para a struct xyz
n1:	.double 2.718281828459045
str1:	.asciiz "Str_1"
str2:	.asciiz "Str_2"
	.text
	.globl f1
f1:	
	la $t0,xyz		# xyz s1;
	la $t1,str1
	sw $t1,0($t0)		# s1 -> a1
	
	li $t5,2021
	sw $t5,16($t0)		# s1 -> i
	
	la $t1,str2
	sw $t1,20($t0)		# s1 -> a2
	
	l.d $f0,n1
	s.d $f0,40($t0)		# s1 -> g
	
	s.d $f0,40($t0)		# return s1.g;

	jr $ra			# Fim da função f1