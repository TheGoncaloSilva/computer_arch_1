	# Função main (chama e testa a função xtoy)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores inteiros
	# e registos $f20... para salvaguardar valores vírgula flututante
	# Salvaguardar valor de $ra
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Incorpora as funções presentes no mesmo diretório (xtoy)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
	.data
	.eqv READ_FLOAT,6
	.eqv READ_INT,5
	.eqv PRINT_FLOAT,2	# $f12 = float;
	.eqv PRINT_STRING,4
str1:	.asciiz "\nBase: "
str2:	.asciiz "\nExpoente: "
str3:	.asciiz "\nResultado: "
	.text
	.globl main
main:	
	addiu $sp,$sp,-4	# reservar espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1);
	
	li $v0,READ_FLOAT
	syscall			# $f0 = read_float();
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2);
	
	li $v0,READ_INT
	syscall			# $v0 = read_int();
	
	mov.s $f12,$f0		# $f12 = x;
	move $a0,$v0		# $a0 = y;
	jal xtoy		# xtoy(x,y);
	
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string(str3)
	
	mov.s $f12,$f0		# $f12 = xtoy(x,y)
	li $v0,PRINT_FLOAT	
	syscall			# print_float(xtoy(x,y))
	
	li $v0,0		# return 0;
	lw $ra,0($sp)		# repor $ra
	addiu $sp,$sp,4		# libertar o espaço do stack	
	jr $ra			# Fim do programa
