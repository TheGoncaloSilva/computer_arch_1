	# Desabilitar "assemble all files in directory" setting				
				# Mapa de registos:
	.data
	.eqv PRINT_STRING,4
	.eqv PRINT_CHAR,11	# $a0 = character
	.eqv PRINT_INTU10,36
	.eqv PRINT_FLOAT,2	# $f12 = number 
	.eqv READ_STRING,8	# $a0 = buf, $a1 = length
	.eqv READ_INT,5
str1:	.asciiz "\nN. Mec: "
str2: 	.asciiz "\nNome: "
str3: 	.asciiz "\nNota: "
	.align 2		# alinhar a 4 (maior alinhamento da estrutura)
	
				# typedef struct{
stg:	.word 72343		# int id_number
	.asciiz "Napoleao"	# char first_name[18]
	.space 9		# garantir que o offset é 22
	.asciiz "Bonaparte"	# char last_name[15]
	.space 5		# garantir que o offset é 40
	.float 5.1		# float grade (já faz alinhamento)
				# } student;
	.text
	.globl main
main:
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	la $t0,stg		# $t0 = &stg
	lw $a0,0($t0)		# $a0 = stg.id_number
	li $v0,PRINT_INTU10
	syscall			# print_intu10(stg.id_number)
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2)
	
	addiu $a0,$t0,22	# $a0 = &stg.last_name
	li $v0,PRINT_STRING
	syscall
	
	li $a0,','
	li $v0,PRINT_CHAR
	syscall			# print_char(',');
	
	addiu $a0,$t0,4		# $a0 = &stg.last_first
	li $v0,PRINT_STRING
	syscall
	
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string(str3)
	
	l.s $f12,40($t0)	# $f12 = stg.grade
	li $v0,PRINT_FLOAT
	syscall			# print_float(stg.grade)


	jr $ra			# Fim do programa