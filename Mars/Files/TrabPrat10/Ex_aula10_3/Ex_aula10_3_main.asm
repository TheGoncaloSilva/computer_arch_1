	# Função main (chama e testa as funções var e stdev)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores inteiros
	# e registos $f20... para salvaguardar valores vírgula flututante
	# Salvaguardar valor de $ra
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Incorpora as funções presentes no mesmo diretório (var e stdev)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
				# i: $t0
				# array: $t1
				
	.data
	.eqv SIZE, 5
	.eqv PRINT_DOUBLE,3
	.eqv READ_DOUBLE,7
	.eqv PRINT_STRING,4
w1:	.asciiz "\nValor: "
w2:	.asciiz "\nVariância: "
w3:	.asciiz "\nDesvio Padrão:"
	.align 3		# array de doubles * 8
array:	.space 40		# 5 * 8
	.text
	.globl main
main:	
	addiu $sp,$sp,-4	# Reservar o espaço na Stack
	sw $ra,0($sp)		# Salvaguardar $ra
	
	la $t1,array		# $t1 = &array[0];
	li $t0,0		# i = 0;
for1:	bge $t0,SIZE,endf1	# for(i=0;i<SIZE,i++){
	
	la $a0,w1
	li $v0,PRINT_STRING
	syscall			# print_string(w1);
	li $v0,READ_DOUBLE	# $f0 = read_double();
	syscall
	
	sll $t2,$t0,3		# $t2 = i << 3
	addu $t2,$t2,$t1	# $t2 = &array[i];
	s.d $f0,0($t2)		# array[i] = $f0
	
	addiu $t0,$t0,1		# i++;
	j for1
endf1:				# }
	move $a0,$t1		# $a0 = *array;
	li $a1,SIZE		# $a1 = SIZE;
	jal var			# $f0 = var(*array,nval)
	
	la $a0,w2
	li $v0,PRINT_STRING
	syscall			# print_string(w2);
	
	mov.d $f12,$f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(var(*array,nval))
	
	la $a0,array		# $a0 = *array;
	li $a1,SIZE		# $a1 = SIZE;
	jal stdev		# $f0 = stdev(*array,nval)
	
	la $a0,w3
	li $v0,PRINT_STRING
	syscall			# print_string(w3);
	
	mov.d $f12,$f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(stdev(*array,nval))
	
	lw $ra,0($sp)		# repor $ra
	addiu $sp,$sp,4		# Libertar o espaço na Stack
	jr $ra			# Fim do programa
