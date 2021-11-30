	# Programa que lê argumentos de entrada e imprime
	# Entrada: argc (nº de caracteres), argv[](caracteres)
	# NOTA: A informação fornecida nos argumentos do programa fica automaticamente
	# 	guardada na memória
				# Mapa de registos:
				# $a0: argc (endereço) -> fica no $t0
				# $a1: argv[] (endereço da primeira) -> fica no $t1
				# i: $t2
				# Temp1: $t3
				
	.data
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
str1:	.asciiz	"Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	.text
	.globl main
main:	
	move $t0,$a0		# $t0 = argc
	move $t1,$a1		# $t1 = &argv[]
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	move $a0,$t0
	li $v0,PRINT_INT10
	syscall			# print_int10(argc);
	
	li $t2,0			# i=0;
for:	bge $t2,$t0,endf		# for(i=0; i < argc; i++) {
	sll $t3,$t2,2		# $t3 = i << 2 (i*4)
	addu $t3,$t1,$t3	# $t3 = &argv[0] + i = &argv[i]
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string('\nP');
	
	move $a0,$t2
	li $v0,PRINT_INT10	
	syscall			# print_int10(i);
	
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string(': ');
	
	lw $a0,0($t3)		# $a0 = argv[i]
	li $v0,PRINT_STRING
	syscall			# print_string(argv[i]);
	
	addiu $t2,$t2,1		# i++;
	j for
endf:
	jr $ra 			# FIm do programa
