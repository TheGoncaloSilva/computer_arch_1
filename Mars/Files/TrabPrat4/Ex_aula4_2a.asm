					# Mapa de registos
					# num: $t0
					# p: $t1
					# *p: $t2
	.data
	.eqv SIZE, 20
	.eqv PRINT_INT10, 1		# $a0 = int, $v0 = op
	.eqv READ_STRING, 8		# $a0 = buf, $a1 = length, $v0 = op
str:	.space 21			# array com tamanho SIZE+1
					# a label representa o primeiro espaço do array
	.text
	.globl main
main: 	li $t0,0 			# num = 0;
	
	la $a0,str			# $a0 = buf (endereço da posição inicial do array)
	li $a1,SIZE			# $a1 = tamanho do array
	li $v0, READ_STRING		# valor da operação
	syscall				# num = read_string(str,SIZE)
	
	la $t1,str 			# p = str; ou p = &(str[0]))
	
	# Não preciso de carregar o valor da posição, pois ela é guardada pelo ponteiro p
while: 	
	lb $t2,0($t1) 			# *p = num[i]
	beq $t2,0,endw 			# while(*p != '\0'){
	beq $t2,'0',endif 		# if(str[i] >='0' &&
	bgt $t2,'9',endif 		# str[i] <= '9')
	addi $t0,$t0,1			# num++;
endif:
	addiu $t1,$t1,1			# p++;
	j while				# }
endw: 	
	move $a0,$t0			# print_int10(num);
	li $v0,PRINT_INT10
	syscall
	
	jr $ra 				# termina o programa
