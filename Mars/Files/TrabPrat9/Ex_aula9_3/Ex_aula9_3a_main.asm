	# Função main (chama e testa a função f2c)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores inteiros
	# e registos $f20... para salvaguardar valores vírgula flututante
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (f2c)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
				# i: $t0
				# array[i]: $t1
				# array: $t2
				# double array[i]: $f0
	.data
	.eqv SIZE,10
	.eqv READ_INT,5
	.eqv PRINT_STRING,4
	.eqv PRINT_DOUBLE,3	# $v0 = code, $f12 = value_to_print
str:	.asciiz "Valor: "
str2:	.asciiz "Média: "
	.align 3
array:	.space 80 		# static double a[SIZE];
				# Doubles ocupam duas posições, logo alinhado a 
				# múltiplo de 8 (SIZE * 8) = 80
	.text			
	.globl main
main:	
	addiu $sp,$sp,-4		# reservar espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	
	la $t2,array		# $t2 = array
	li $t0,0			# i = 0;
for:	bge $t0,SIZE,endf	# for(i = 0; i < SIZE; i++) {
	
	la $a0,str
	li $v0,PRINT_STRING
	syscall			# print_string(str)
	
	li $v0,READ_INT
	syscall			# $v0 = read_int()
	
	mtc1 $v0,$f0		# $f0 = read_int()
	cvt.d.w	$f0,$f0		# $f0 = (double) read_int()
	
	sll $t1,$t0,3		# $t1 = i << 3
	addu $t1,$t1,$t2	# $t1 = &array[i]
	s.d $f0,0($t1)		# array[i] = (double)read_int();
	
	addi $t0,$t0,1		# i++;
	j for
endf:				# }
	la $a0,array		# $a0 = array
	li $a1,SIZE		# $a1 = SIZE
	jal average		# $f0 = average(a, SIZE)
	
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(average(a, SIZE));
	
	li $v0,0			# return 0;
	lw $ra,0($sp)		# repôr $ra
	addiu $sp,$sp,4		# libertar o espaço do stack
	jr $ra			# Fim do programa