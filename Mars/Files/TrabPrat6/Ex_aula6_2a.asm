	# Acesso ao array por ponteiros
				# Mapa de registos
				# SIZE: $t0
				# p : $t1
				# pultimo: $t2
	.data
	.eqv SIZE,3
	.eqv PRINT_STRING,4
	.eqv PRINT_CHAR,11
array:	.word str1,str2,str3
str1: 	.asciiz "Array"
str2: 	.asciiz "de"
str3: 	.asciiz "ponteiros"
	.text
	.globl main
main:
	la $t1,array 		# $t1 = p = &array[0] = array
	li $t0,SIZE 		# $t0 = SIZE
	sll $t0,$t0,2 		# $t0 = SIZE << 2 (i*4)
	addu $t2,$t1,$t0	# $t2 = pultimo = array + SIZE
for: 	bgeu $t1,$t2,endf	# for(; p < pultimo; p+=4){
	
	lw $a0,0($t1)
	li $v0,PRINT_STRING
	syscall			# print_string(*p);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\,');
	
	addiu $t1,$t1,4		# p += 4
	j for
endf:
	jr $ra			# Fim do programa
