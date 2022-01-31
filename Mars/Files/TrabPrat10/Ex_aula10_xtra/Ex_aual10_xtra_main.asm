	# Função main, lê 11 valores em Farenheit, converte para graus e mostra várias infos.
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
	.eqv SIZE,11
	.eqv READ_INT,5
	.eqv PRINT_STRING,4
	.eqv PRINT_CHAR,11
	.eqv PRINT_DOUBLE,3	# $v0 = code, $f12 = value_to_print
str:	.asciiz "Valor: "
str2:	.asciiz "\nMédia: "
str3: 	.asciiz "\nMáximo: "
str4:	.asciiz "\nMedições: ["
str5: 	.asciiz "\nMediana: "
str6:	.asciiz "\nVariância: "
str7: 	.asciiz "\nDesvio Padrão: "
	.align 3
array:	.space 88 		# static double a[SIZE];
				# Doubles ocupam duas posições, logo alinhado a 
				# múltiplo de 8 (SIZE * 8) = 80
	.text			
	.globl main
main:	
	addiu $sp,$sp,-4	# reservar espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	
	la $t2,array		# $t2 = array
	li $t0,0		# i = 0;
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
	
	mov.d $f12,$f0		# $f12 = $f0
	jal f2c			# $f0 = f2c(ft) -> Valor traduzido para graus celsius
	
	s.d $f0,0($t1)		# array[i] = (double)read_int();
	
	addi $t0,$t0,1		# i++;
	j for
endf:				# }

	la $a0,str4
	li $v0,PRINT_STRING
	syscall			# print_string("Medições: [")
	
	la $t2,array		# $t2 = array
	li $t0,0		# i = 0;
for2:	bge $t0,SIZE,endf2	# for(i = 0; i < SIZE; i++) {
	
	sll $t1,$t0,3		# $t1 = i << 3
	addu $t1,$t1,$t2	# $t1 = &array[i]
	l.d $f12,0($t1)		# $f12 = array[i]
	li $v0,PRINT_DOUBLE
	syscall			# print_double(array[i])
	
	li $a0,','
	li $v0,PRINT_CHAR
	syscall			# print_char(',')
	
	addi $t0,$t0,1		# i++;
	j for2
endf2:				# }
	li $a0,']'
	li $v0,PRINT_CHAR
	syscall			# print_char(']')
	
	la $a0,array		# $a0 = array
	li $a1,SIZE		# $a1 = SIZE
	jal max			# max(array, SIZE)
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string("Máximo: ")
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(max(array, SIZE));
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string("Média: ")
	la $a0,array		# $a0 = array
	li $a1,SIZE		# $a1 = SIZE
	jal average		# $f0 = average(a, SIZE)
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(average(a, SIZE));
	
	la $a0,str5
	li $v0,PRINT_STRING
	syscall			# print_string("Mediana: ")
	la $a0,array		# $a0 = &array[0];
	li $a1,SIZE		# $a1 = SIZE	
	jal median		# $f0 = median(double *array, int nval);
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(median(*array, nval));
	
	la $a0,str6
	li $v0,PRINT_STRING
	syscall			# print_string("Variância: ")
	la $a0,array		# $a0 = array
	li $a1,SIZE		# $a1 = SIZE
	jal var			# $f0 = var(double *array, int nval)
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(var(*array, nval));
	
	la $a0,str7
	li $v0,PRINT_STRING
	syscall			# print_string("Desvio Padrão: ")
	la $a0,array		# $a0 = &array[0];
	li $a1,SIZE		# $a1 = SIZE	
	jal stdev		# $f0 = stdev(double *array, int nval);
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(stdev( *array, nval));
	
	li $v0,0		# return 0;
	lw $ra,0($sp)		# repor $ra
	addiu $sp,$sp,4		# libertar o espaço da stack
	jr $ra			# Fim do programa
