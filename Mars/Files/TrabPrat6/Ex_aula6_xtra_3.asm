	# Lê e imprime 3 Strings, caracter por caracter (separados por '-')
	# Acesso ao array por ponteiros
				# Mapa de registos:
				# p : $t0
				# *p: $t1
				# **p: $t2
				# pUltimo: $t3
				# Temp1: $t4
	.data
	.eqv SIZE,3
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
	.eqv PRINT_INT16,34
welstr:	.asciiz "\nString #"
twodots:.asciiz ": "
array:	.word str1,str2,str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.text
	.globl main
main:	
	la $t0,array		# p = &array[0]
	li $t3,SIZE		# pUltimo = SIZE
	sll $t3,$t3,2		# pUltimo = SIZE << 2 (SIZE*4)
	addu $t3,$t3,$t0		# pUltimo = array + SIZE
	
for:	bge $t0,$t3,endf		# for(p=array;p<pUltimo,p+=4) {
	
	la $a0,welstr
	li $v0,PRINT_STRING
	syscall			# print_string("\nString #");
	
	move $a0,$t0		# $a0 = p;
	li $v0,PRINT_INT16
	syscall			# print_int10(i);
	
	la $a0,twodots
	li $v0,PRINT_STRING
	syscall
	
	lw $t1,0($t0)		# $t1 = *p;
	li $t2,1			# **p=0; (Reiniciar o valor do objeto para executar o while
				# nas seguintes iteração, em alternativa usar o do-while)
while:	beq $t2,'\0',endw	# while(**p != '\0'){
	
	lb $t2,0($t1)		# $t2 = **p;
	
	move $a0,$t2		# $a0 = **p
	li $v0,PRINT_CHAR
	syscall			# print_char(**p);
	
	li $a0,'-'
	syscall			# print_char('-');
		
	addiu $t1,$t1,1		# *p++; (cada posição da palavra)
	j while
endw:				# }
	addiu $t0,$t0,4		# p += 4;
	j for
endf:				# }
	jr $ra 			# fim do programa
	