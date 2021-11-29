	# Acesso ao array por indices
				# Mapa de registos:
				# i: $t0
				# &array[0]: $t1
				# &array[i]: $t2
	.data
	.eqv SIZE,3
	.eqv PRINT_STRING,4
	.eqv PRINT_CHAR,11
array:	.word str1,str2,str3
				# Endereço inicial do Array: 0x10010000
str1: 	.asciiz "Array"		# Começa: 0x10010000 (6 posiçóes - 0 a 5)
str2: 	.asciiz "de"		# Começa: 0x10010006 (3 posições - 6 a 8)
str3: 	.asciiz "ponteiros"	# Começa: 0x1001009 (9 posições - 9 a 19)
				# 19 posições de memória e alinha automaticamente a 4
				# sendo que alinha para 20 
				# 20 + 12 (4 bytes de cada posição)
				# 32 posições de memória
	.text
	.globl main
main:
	li $t0,0			# i = 0;
for: 	bge $t0,SIZE,endf	# for(i=0; i < SIZE; i++) {
	la $t1,array 		# $t1 = &array[0]
	sll $t2,$t0,2		# $t2 = i << 2 (i*4)
	addu $t2,$t1,$t2	# $t2 = &array[i] (&array[0] + i)
	lw $a0,0($t2) 		# $a0 = array[i]
	li $v0,PRINT_STRING
	syscall			# print_string
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
	
				# Imprimir o segundo caracter de cada string
	lw $a0,0($t2) 		# $a0 = array[i]
	lb $a0,1($a0)		# $a0 = array[i][1]
	li $v0,PRINT_CHAR
	syscall			# print_char(array[i][1]);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
	
	addi $t0,$t0,1		# i++;
	j for
endf:				# }
	jr $ra
