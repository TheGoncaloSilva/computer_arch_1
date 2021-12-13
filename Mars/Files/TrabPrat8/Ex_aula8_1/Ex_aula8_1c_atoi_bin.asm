	# atoi = Ask TO Integer
	# A  função  seguinte  converte  para  um  inteiro  de  32  bits  a  quantidade  representada  por  uma 
	# string  binária
	# Ex: atoi("101101") -> 45
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não devem ser usados registos $sx
				# Mapa de registos 
				# res:  $v0 
				# s:  $a0 
				# *s:  $t0 
				# digit:  $t1 
	.text
	.globl atoi_bin				 
atoi_bin:
	li $v0,0   		# res = 0; 
while: 	lb $t0,0($a0)   		# $t0 = *s 
  	blt $t0,'0',endw		# while( (*s >= '0') && (*s <= '1') ) 
  	bgt $t0,'1',endw		# { 
  	sub $t1,$t0,'0' 		#    digit = *s – '0'(0x30)
  	addiu $a0,$a0,1 		#    s++; 
  	mul $v0,$v0,2	   	#    res = 2 * res; (2 por causa de ser binário - base 2)
  	add $v0,$v0,$t1 		#    res = 2 * res + digit; 
  	j while
endw:  		     		# } 
  	jr $ra    		# termina sub-rotina
