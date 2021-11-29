				# Mapa de registos:
				# i : $t0
				# j: $t1
				# Temp1: $t2
				# array[i][j]: $t3
				
	.data
	.eqv SIZE,3
	.eqv PRINT_CHAR,11
	.eqv PRINT_INT10,1
	.eqv PRINT_STRING,4
welstr:	.asciiz "\nString #"
twodots:.asciiz ": "
array:	.word str1,str2,str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.text
	.globl main
main:	
	li $t0,0			# i=0;
for:	bge $t0,SIZE,endf	# for(i=0; i < SIZE; i++) {
	
	la $a0,welstr
	li $v0,PRINT_STRING
	syscall			# print_string("\nString #");
	
	move $a0,$t0		# $a0 = i;
	li $v0,PRINT_INT10
	syscall			# print_int10(i);
	
	la $a0,twodots
	li $v0,PRINT_STRING
	syscall
	
	li $t1,0			# j = 0;	
while:	
	la $t3,array 		# $t3 = &array[0]
	sll $t2,$t0,2 		# $t2 = i << 2
	addu $t3,$t3,$t2 	# $t3 = &array[i] (&array[0]+i)
	lw $t3,0($t3) 		# $t3 = array[i] = &array[i][0]
	addu $t3,$t3,$t1 	# $t3 = &array[i][j]
	lb $t3,0($t3) 		# $a0 = array[i][j]
	beq $t3,'\0',endw	# while(array[i][j] != '\0') {
	
	move $a0,$t3		# $a0 = $t3
	li $v0,PRINT_CHAR
	syscall			# print_char(array[i][j]);
	
	li $a0,'-'
	syscall			# print_char('-');
	
	addiu $t1,$t1,1		# j++;
	j while
endw:				# }
	addi $t0,$t0,1		# i++;
	j for
endf:				# }

	jr $ra			# Fim do programa
