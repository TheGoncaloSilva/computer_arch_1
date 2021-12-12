	# Função main (chama e testa a função strcat)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (atoi)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
				
	.data
	.eqv PRINT_INT10,1
str1:	.asciiz "2020 e 2024 sao anos bissextos"		
				# static char str[]
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
	
	li $v0,0			# return 0;
 	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack
	jr $ra 			# Fim do programa