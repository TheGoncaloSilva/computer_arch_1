# Fun??o strrev
	# Sub rotina interm?dia, usar os registos $sx para salvaguardar valores
				# Mapa de registos: 
				# str: $a0 -> $s0 (argumento ? passado em $a0) 
				# p1:  $s1  (registo callee-saved) 
				# p2:  $s2  (registo callee-saved) 
	.text
	.globl strrev
strrev: 	addiu $sp,$sp,-16  	# reserva espa?o na stack 
  	sw $ra,0($sp)   		# guarda endere?o de retorno 
  	sw $s0,4($sp)   		# guarda valor dos registos 
  	sw $s1,8($sp)   		#  $s0, $s1 e $s2 
  	sw $s2,12($sp)  		# 
  	move $s0,$a0   		# registo "callee-saved" (Pr?pria fun??o salvaguarda os dados)
  	move $s1,$a0   		# p1 = str 
  	move $s2,$a0   		# p2 = str 
  	
while1: lb $t0,0($s2)		# $t0 = *p2;
  	beq $t0,'\0',endw1	# while( *p2 != '\0' ) { 
  	addiu $s2,$s2,1 		# p2++;(Array de chars, incrementa ou diminui 1)
  	j while1    		# }
endw1:
  	subu $s2,$s2,1  		# p2--;(subtrai o '\0')
while2: bgeu $s1,$s2,endw2	# while(p1 < p2) { 
  	move $a0,$s1   		# $a0 = p1
  	move $a1,$s2   		# $a1 = p2
  	jal exchange  		# exchange(p1,p2) 
  	addiu $s1,$s1,1		# p1++;
  	subu $s2,$s2,1		# p2--; 
  	j while2    		# }
endw2:
  	move $v0,$s0   		# return str 
  	lw $ra,0($sp)   		# rep?e endere?o de retorno 
  	lw $s0,4($sp)   		# rep?e o valor dos registos 
  	lw $s1,8($sp)   		#  $s0, $s1 e $s2 
  	lw $s2,12($sp)   	# 
  	addiu $sp,$sp,16		# liberta espa?o da stack 
  	jr $ra    		# termina a sub-rotina 