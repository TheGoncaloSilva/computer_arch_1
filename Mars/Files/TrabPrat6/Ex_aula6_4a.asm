	# Programa que l� argumentos de entrada e imprime
	# Entrada: argc (n� de caracteres), argv[](caracteres)
	# NOTA: A informa��o fornecida nos argumentos do programa fica automaticamente
	# 	guardada na mem�ria
				# Mapa de registos:
				# $a0: argc (endere�o) -> fica no $t0
				# $a1: argv[] (endere�o da primeira) -> fica no $t1
				#
				
	.data
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
str1:	.asciiz	"Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	.text
	.globl main
main:	
	move $t0,$a0		# $t0 = &argc
	move $t1,$a1		# $t1 = &argv[]
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	move $a0,$t0
	li $v0,PRINT_INT10
	syscall			# print_int10(argc);
	
	lw $a0,4($t1)		# $a0 = argc
	li $v0,PRINT_STRING
	syscall

	jr $ra 			# FIm do programa