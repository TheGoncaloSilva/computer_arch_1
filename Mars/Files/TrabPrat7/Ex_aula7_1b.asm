	# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
				# Mapa de registos
				# entrada_1 sub-rotina(strlen): $a0
				# saida_1 sub-rotina(strlen): $v0
	.data
	.eqv PRINT_INT10,1
str:	.asciiz "Arquitetura de computadores I"
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
				# arquitetura "caller-saved"
	la $a0,str		# $a0 = str (registo de entrada para a subrotina)
	jal strlen		# strlen(str);
	move $a0,$v0
	li $v0,PRINT_INT10
	syscall			# print_int10(strlen(str));
	
	li $v0,0			# return 0;
	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,4		# liberta espaço da stack
	jr $ra 			# Fim da fução main
	
	# O argumento da função é passado em $a0 
	# O resultado é devolvido em $v0 
	# Sub-rotina terminal: não devem ser usados registos $sx
				# Mapa de registos:
				# s: $a0
				# *s: $t0
				# len: $t1
				# retorno: $v0
				 
strlen: li $t1,0   		# len = 0; 
while: 	lb $t0,0($a0)   		# while(*s++ != '\0') 
  	addiu $a0,$a0,1  	# (array de caracteres, pos 1 a 1)
  	beq $t0,'\0',endw 	# { 
  	addi $t1,$t1,1  		#    len++;
  	j while    		# } 
endw: 	move $v0,$t1   		# return len; 
  	jr $ra    		# Fim da função strlen
