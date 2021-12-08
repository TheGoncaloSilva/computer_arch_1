# O argumento da função é passado em $a0 
	# O resultado é devolvido em $v0 
	# Sub-rotina terminal: não devem ser usados registos $sx
				# Mapa de registos:
				# s: $a0
				# *s: $t0
				# len: $t1
				# retorno: $v0
	.text
	.globl strlen			 
strlen: li $t1,0   		# len = 0; 
while: 	lb $t0,0($a0)   		# while(*s++ != '\0') 
  	addiu $a0,$a0,1  	# (array de caracteres, pos 1 a 1)
  	beq $t0,'\0',endw 	# { 
  	addi $t1,$t1,1  		#    len++;
  	j while    		# } 
endw: 	move $v0,$t1   		# return len; 
  	jr $ra    		# Fim da função strlen
