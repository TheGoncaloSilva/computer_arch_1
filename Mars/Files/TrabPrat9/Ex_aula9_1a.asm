	# A seguinte Função main lê um valor inteiro, multiplica-o por uma constante real 
	# e apresenta o resultado
	# Registos para virgulas $fxy, até 32 registos
	# No entanto, só se deve usar registos pares, pois os registos ímpares
	# são usados quando existem operações de VF com precisão dupla
	# Se estivermos a trabalhar com funções e VF, usam-se os registos
	# acima do $f20 com as mesmas diretivas dos registos $sx
	# ,ou seja, é preciso salvaguardá-los antes de os usar
	# Desabilitar o "Assemble all files in directory" setting
				# Mapa de registos:
				# float res: $f0
				# val: $t0
	.data
	.eqv READ_INT,5
	.eqv PRINT_FLOAT,2	# # $v0 = code, 	$f12 = value_to_print
n1:	.float 2.59375
zero: 	.float 0.0
	.text
	.globl main
main:
do:				# {
	li $v0,READ_INT
	syscall			# $v0 = read_int();
	move $t0,$v0		# $t0 = val
	
	
	mtc1 $t0,$f0		# $f0 = $t0
	cvt.s.w $f0,$f0		# (float) val
	
	l.s $f2,n1		# $f2 = float res => $f2 = 2.59375
	mul.s $f0,$f0,$f2	# res = (float)val * 2.59375
	
	li $v0,PRINT_FLOAT
	mov.s $f12,$f0		# $f12 = $f0
	syscall			# print_float(res);
	
	l.s $f2,zero		# $f2 = float zero	
	c.eq.s $f0,$f2		# } while (res != 0.0);	
	bc1f do			# testar se a condição acima foi bem sucedida e saltar
while:	

	li $v0,0			# return 0;
	jr $ra			# Fim do programa