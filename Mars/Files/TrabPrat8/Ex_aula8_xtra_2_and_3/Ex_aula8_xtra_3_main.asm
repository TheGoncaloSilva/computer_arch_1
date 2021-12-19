	# Função main (chama e testa a função insert_char)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (strlen e insert_char)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# insert_pos: $s0
	.data
	.eqv PRINT_STRING,4
	.eqv READ_STRING,8
	.eqv READ_INT,5
str1:	.space 101		# static char str1[101]
	.align 2
str2:	.space 51		# static char str2[51]
well1:	.asciiz "Enter a string: "
well2:	.asciiz "Enter a string to insert: "
well3:	.asciiz "Enter the position: "
well4:	.asciiz "Original string: "
well5:	.asciiz "\nModified string: "
well6:	.asciiz "\n"
	.text
	.globl main
main:
	addiu $sp,$sp,-8		# reservar espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	sw $s0,4($sp)		# salvaguardar $s0

	la $a0,well1
	li $v0,PRINT_STRING
	syscall			# print_string(well1)
	
	la $a0,str1
	li $a1,50
	li $v0,READ_STRING
	syscall			# read_string(str1,50)
	
	la $a0,well2
	li $v0,PRINT_STRING
	syscall			# print_string(well2)

	la $a0,str2
	li $a1,50
	li $v0,READ_STRING
	syscall			# read_string(str2,50)
	
	la $a0,well3
	li $v0,PRINT_STRING
	syscall			# print_string(well3)
	
	li $v0,READ_INT
	syscall			# $v0 = read_int();
	move $s0,$v0		# insert_pos = $v0

	la $a0,well4
	li $v0,PRINT_STRING
	syscall			# print_string(well4)
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	la $a0,str1		# $a0 = str1
	la $a1,str2		# $a1 = str2
	move $a2,$s0		# $a2 = insert_pos
	jal insert_char		# insert_char(str1, str2, insert_pos)
	
	la $a0,well5
	li $v0,PRINT_STRING
	syscall			# print_string(well5)
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	la $a0,well6
	li $v0,PRINT_STRING
	syscall			# print_string(well6)

	li $v0,0			# return 0;
	lw $ra,0($sp)		# repôr $ra
	lw $s0,4($sp)		# repôr $s0
	addiu $sp,$sp,8		# libertar espaço da stack
	jr $ra 			# Fim do programa