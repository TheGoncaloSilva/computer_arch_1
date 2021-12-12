	# A  fun��o  seguinte  converte  para  um  inteiro  de  32  bits  a  quantidade  representada  por  uma 
	# string  num�rica  em  que  cada  carater  representa  o  c�digo  ASCII  de  um  d�gito  decimal 
	# (i.e., 0 - 9). A convers�o termina quando � encontrado um carater n�o num�rico.
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: n�o devem ser usados registos $sx
				# Mapa de registos 
				# res:  $v0 
				# s:  $a0 
				# *s:  $t0 
				# digit:  $t1 
	.text
	.globl atoi				 
atoi: 	li $v0,0   		# res = 0; 
while: 	lb $t0,0($a0)   		# $t0 = *s 
  	blt $t0,'0',endw		# while( (*s >= '0') && (*s <= '9') ) 
  	bgt $t0,'9',endw		# { 
  	sub $t1,$t0,'0' 		#    digit = *s � '0' 
  	addiu $a0,$a0,1 		#    s++; 
  	mul $v0,$v0,10   	#    res = 10 * res; 
  	add $v0,$v0,$t1 		#    res = 10 * res + digit; 
  	j while
endw:  		     		# } 
  	jr $ra    		# termina sub-rotina
