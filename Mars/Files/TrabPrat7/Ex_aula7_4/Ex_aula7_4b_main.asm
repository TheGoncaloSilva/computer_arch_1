	# Função main (chama e testa a função strcat)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (strcat, strcpy)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# exit_value: 0;
	.data
	.eqv SIZE,50
	.eqv PRINT_STRING,4
	.eqv PRINT_CHAR,11
str1:	.asciiz "Arquitetura de "
	.align 2			# Alinha o array seguinte a *4
str2:	.space SIZE		# static char[] str2[50];
str3:	.asciiz "Computadores I"
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	la $a0,str2		# $a0 = str2
	la $a1,str1		# $a1 = str1
	jal strcpy		# strcpy(str2, str1); 
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2); 
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_string("\n"); 
	
	la $a0,str2		# $a0 = str2
	la $a1,str3		# $a1 = str3
	jal strcat		# $v0 = strcat(str2, "Computadores I")
	
	move $a0,$v0		# $a0 = $v0
	li $v0,PRINT_STRING
	syscall 			# print_string( strcat(str2, "Computadores I") ); 

 	li $v0,0			# return 0;
 	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack	
 	jr $ra			# Fim do programa