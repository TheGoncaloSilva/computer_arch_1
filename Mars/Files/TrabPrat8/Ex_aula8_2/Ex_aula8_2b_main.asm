	# Função main (chama e testa a função itoa)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (itoa,strrev,toascii)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
				# str:  $s0 
				# val:  $s1 
				# O main é, neste caso, uma sub-rotina intermédia 
  	.data  
  	.eqv STR_MAX_SIZE,33 
  	.eqv read_int,5
  	.eqv print_string,4
  	.eqv PRINT_CHAR,11
	.align 2
str: 	.space STR_MAX_SIZE
 	.text 
  	.globl  main 
main: 	addiu $sp,$sp,-12		# reserva espaço na stack 
  	sw $ra,0($sp)		# salvaguarda $ra
  	sw $s0,4($sp)
  	sw $s1,8($sp)     	# guarda registos $sx na stack 
  				# arquitetura "callee-saved"
do:       			# do { 
  	li $v0,read_int 
  	syscall     		# 
  	move $s1,$v0   		#    val = read_int() 
  	
  	move $a0,$s1		# entrada $a0 = val
  	li $a1,2			# entrada $a1 = 2
  	la $a2,str		# entrada $a2 = str
  	jal itoa			# itoa(val, 2, str)
  	move $a0,$v0
  	li $v0,print_string
  	syscall			# print_string( itoa(val, 2, str) );
  	
  	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
  	
  	move $a0,$s1		# entrada $a0 = val
  	li $a1,8			# entrad8 $a1 = 8
  	la $a2,str		# entrada $a2 = str
  	jal itoa			# itoa(val, 8, str)
  	move $a0,$v0
  	li $v0,print_string
  	syscall			# print_string( itoa(val, 8, str) ); 
  	
  	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
  	
  	move $a0,$s1		# entrada $a0 = val
  	li $a1,16		# entrada $a1 = 16
  	la $a2,str		# entrada $a2 = str
  	jal itoa			# itoa(val, 16, str)
  	move $a0,$v0
  	li $v0,print_string
  	syscall			# print_string( itoa(val, 16, str) ); 
  	
  	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
				# Exercicio 2c
	move $a0,$s1		# entrada $a0 = val
	li $a1,2			# entrada $a1 = base
	jal print_int		# print_int_ac1(val,base)
  		
while: 	bne $s1,0,do   		# } while(val != 0) 
  	li $v0,0    		# return 0; 
  	lw $ra,0($sp) 		# repõe registo $ra 
  	lw $s0,4($sp)     	# repoe registos $sx 
  	lw $s1,8($sp)
  	addiu $sp,$sp,12   	# liberta espaço na stack 
  	jr $ra    		# termina programa 
