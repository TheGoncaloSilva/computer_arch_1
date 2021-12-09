	# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Incorpora as funções presentes no mesmo diretório (strcpy, strlen, exchange e strrev)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# exit_value: $s0
				# strlen(str): $s1
	.data
	.eqv STR_MAX_SIZE,30
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
		#"alo"
				# static char str1[]
	.align 2		
str2:	.space 31		# static char str2[STR_MAX_SIZE + 1]
str3:	.asciiz "String too long: "
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	
	la $a0,str1		# $a0 = str1 (registo de entrada para a subrotina)
	jal strlen		# $v0 = strlen(str1);
	move $s1,$v0		# $s1 = $v0
	
if:	bgt $s1,STR_MAX_SIZE,else # if(strlen(str1) <= STR_MAX_SIZE) {
	la $a0,str2		# $a0 = str2
	la $a1,str1		# $a1 = str1
	jal strcpy		# strcpy(str2, str1); 
  	move $a0,$v0
  	li $v0,PRINT_STRING
  	syscall			# print_string(str2); 
  	li $a0,'\n'		
  	li $v0,PRINT_CHAR
  	syscall			# print_string("\n"); 
  	
  	la $a0,str2		# $a0 = str2
  	jal strrev		# $v0 = strrev(str2)
  	
  	move $a0,$v0
  	li $v0,PRINT_STRING
  	syscall			# print_string(strrev(str2));
  	 
  	li $s0,0			# exit_value = 0; 
  	j endif
else:	 			# } else { 
 	la $a0,str3
 	li $v0,PRINT_STRING
 	syscall			# print_string("String too long: "); 
  	
  	move $a0,$s1		# $a0 = $s1
  	li $v0,PRINT_INT10
  	syscall			# print_int10(strlen(str1)); 
  	
  	li $s0,1			# exit_value = -1; 
endif:		 		# }  		
 	move $v0,$s0		# return exit_value;
 	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack	
 	jr $ra			# Fim do programa
