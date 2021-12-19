	# Função main (chama e testa a função div_int)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (div_int)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# dividendo: $t0
				# divisor: $t1
	.data
	.eqv PRINT_STRING,4
	.eqv READ_INT,5
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
str1:	.asciiz "Dividendo: "
str2: 	.asciiz "\nDivisor: "
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1);
	
	li $v0,READ_INT
	syscall
	move $t0,$v0		# $t0 = dividendo
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2);
	
	li $v0,READ_INT
	syscall
	move $t1,$v0		# $t1 = divisor
	
	move $a0,$t0		# $a0 = dividendo
	move $a1,$t1		# $a1 = divisor
	jal div_int		# div_int(dividendo, divisor); 
	move $t2,$v0
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n')
	
	move $a0,$t2		# $a0 = div_int(dividendo, divisor)
	li $v0,PRINT_INT10
	syscall			# print_int10(div_int(dividendo, divisor));
	
 	li $v0,0			# return 0;
 	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack	
 	jr $ra			# Fim do programa
