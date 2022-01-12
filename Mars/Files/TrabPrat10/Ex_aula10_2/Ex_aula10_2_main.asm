	# Função main (chama e testa a função sqrt)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores inteiros
	# e registos $f20... para salvaguardar valores vírgula flututante
	# Salvaguardar valor de $ra
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Incorpora as funções presentes no mesmo diretório (xtoy)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
	.data
	.eqv READ_DOUBLE,7
	.eqv PRINT_DOUBLE,3	# $f12 = double;
	.eqv PRINT_STRING,4
str1:	.asciiz "\nRaiz: "
str2:	.asciiz "\nResultado: "
	.text
	.globl main
main:	
	addiu $sp,$sp,-4	# reservar espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1);
	
	li $v0,READ_DOUBLE
	syscall			# $f0 = read_double();
	
	mov.d $f12,$f0		# $f12 = raiz;
	jal sqrt		# sqrt(raiz);
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str3)
	
	mov.d $f12,$f0		# $f12 = sqrt(raiz)
	li $v0,PRINT_DOUBLE	
	syscall			# print_double(sqrt(raiz))
	
	li $v0,0		# return 0;
	lw $ra,0($sp)		# repor $ra
	addiu $sp,$sp,4		# libertar o espaço do stack	
	jr $ra			# Fim do programa
