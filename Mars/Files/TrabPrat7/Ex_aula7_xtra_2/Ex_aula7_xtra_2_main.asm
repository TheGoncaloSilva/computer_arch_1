	# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (insert, print_array)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# i: $s0
				# array_size: $s1
				# insert_size: $s2
				# insert_pos: $s3
				# array[0]: $t0
				# array[i]: $t1
	.data
	.eqv SIZE,50
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
	.eqv READ_INT,5
array:	.space 200		# array de inteiros, SIZE * 4
str1:	.asciiz "Size of array : "
str2:	.asciiz "array["
str3:	.asciiz "] = "
str4:	.asciiz "Enter the value to be inserted: "
str5:	.asciiz "Enter the position: "
str6: 	.asciiz "\nOriginal array: "
str7: 	.asciiz "\nModified array: "
	.text
	.globl main
main:	
	addiu $sp,$sp,-20  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	sw $s0,4($sp)		# salvaguarda $s0
	sw $s1,8($sp)		# salvaguarda $s1
	sw $s2,12($sp)		# salvaguarda $s2
	sw $s3,16($sp)		# salvaguarda $s3
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	li $v0,READ_INT
	syscall			# read_int()
	move $s1,$v0		# array_size = read_int()
	
	la $t0,array		# $t0 = &array[0]
	li $s0,0			# i = 0;
for:	bge $s0,$s1,endf		# for(i=0; i < array_size; i++) {
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2)
	move $a0,$s0		# $a0 = i
	li $v0,PRINT_INT10	
	syscall			# print_int10(i)
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string(str3)
	
	sll $t1,$s0,2		# $t0 = i << 2
	addu $t1,$t1,$t0	# &array[i] = i + &array[0]
	
	li $v0,READ_INT
	syscall			# read_int()
	sw $v0,0($t1)		# array[i] = read_int();
	
	addiu $s0,$s0,1		# i++;
	j for
endf:				# }
	la $a0,str4
	li $v0,PRINT_STRING
	syscall			# print_string(str4)
	
	li $v0,READ_INT
	syscall			# read_int();
	move $s2,$v0		# $s2 = read_int()
	
	la $a0,str5
	li $v0,PRINT_STRING
	syscall			# print_string(str5)
	
	li $v0,READ_INT
	syscall			# read_int();
	move $s3,$v0		# $s3 = read_int()
	
	la $a0,str6
	li $v0,PRINT_STRING
	syscall			# print_string(str6)
	
	la $a0,array		# $a0 = array
	move $a1,$s1		# $a1 = array_size
	jal print_array
	
	la $a0,array		# $a0 = array
	move $a1,$s2		# $a1 = value
	move $a2,$s3		# $a2 = pos
	move $a3,$s1		# $a3 = array_size
	jal insert		# insert(array, value, pos, SIZE); 
	
	la $a0,str7
	li $v0,PRINT_STRING
	syscall			# print_string(str7)
	
	la $a0,array		# $a0 = array
	move $a1,$s1		# $a1 = array_size
	addi $a1,$a1,1		# $a1 = array_size + 1
	jal print_array		# print_array(array,array_size + 1)
	
 	li $v0,0			# return 0;
 	lw $ra,0($sp)		# repõe o valor de $ra
 	lw $s0,4($sp)		# repõe o valor de $ra
 	lw $s1,8($sp)		# repõe o valor de $ra
 	lw $s2,12($sp)		# repõe o valor de $ra
 	lw $s3,16($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack	
 	jr $ra			# Fim do programa
