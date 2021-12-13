	# Função main (chama e testa a função strcat)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (atoi)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
				
	.data
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
str1:	.asciiz "2020 e 2024 sao anos bissextos"		
				# static char str[]
str2:	.asciiz "101101"	# 1c_atoi_bin
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	
	la $a0,str1
	jal atoi			# atoi(str)
	
	move $a0,$v0
	li $v0,PRINT_INT10
	syscall			# print_int10( atoi(str) );
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
	
	la $a0,str2
	jal atoi_bin		# atoi_bin(str2)
	
	move $a0,$v0
	li $v0,PRINT_INT10
	syscall			# print_int10( atoi_bin(str) );
	
	li $v0,0			# return 0;
 	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack
	jr $ra 			# Fim do programa
