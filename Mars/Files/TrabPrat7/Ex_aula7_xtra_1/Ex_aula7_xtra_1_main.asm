	# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (insert, print_array)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# 
	.data
	.eqv SIZE,12
	.eqv PRINT_STRING,4
array:	.word 1,4,67,82,94,55,72,89,98,100,11,4
str:	.asciiz "Parâmetros Errados"
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	
	la $a0,array		# $a0 = array
	li $a1,555		# $a1 = value
	li $a2,6			# $a2 = pos
	li $a3,SIZE		# $a3 = SIZE
	jal insert		# insert(array, value, pos, SIZE); 
	
if:	bne $v0,0,else		# if($v0 == 0){
	la $a0,array		# $a0 = array
	li $a1,SIZE		# $a1 = SIZE
	jal print_array
	j endif
else:				# } else {
	la $a0,str
	li $v0,PRINT_STRING
	syscall			# print_string(str);
endif:				# }	
 	li $v0,0			# return 0;
 	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack	
 	jr $ra			# Fim do programa
