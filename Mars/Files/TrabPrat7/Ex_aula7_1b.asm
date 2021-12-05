	# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
				# Mapa de registos
				# entrada_1 sub-rotina(strlen):
				# saida_1 sub-rotina(strlen): 
	.data
	.eqv PRINT_INT10,1
str:	.asciiz "Arquitetura de computadores I"
	.text
	.globl main
main:	
	move $s0,$ra		# salvaguarda $ra
	la $a0,str		# $a0 = str (registo de entrada para a subrotina)
	
	jal strlen		# strlen(str);
	
	move $a0,$v0
	li $v0,PRINT_INT10
	syscall			# print_int10(strlen(str));
	
	move $ra,$s0		# $s0 = $ra
	li $v0,0			# return 0;
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