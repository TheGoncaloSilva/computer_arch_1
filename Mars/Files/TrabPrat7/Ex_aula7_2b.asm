	# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores	
				# Mapa de registos:
				#
				#
	.data
	.eqv PRINT_STRING,4
str:	.asciiz "ITED - orievA ed edadisrevinU"
	.text
	.globl main
main: 	
	move $s0,$ra		# salvaguarda $ra
	la $a0,str		# $a0 = str (registo de entrada para a subrotina)
	
	jal strrev		# strlen(str);
	
	move $a0,$v0
	li $v0,PRINT_INT10
	syscall			# print_int10(strrev(str));
	
	move $ra,$s0		# $s0 = $ra
	
	li $v0,0			# return 0;
	jr $ra			# Fim da funçáo main 	