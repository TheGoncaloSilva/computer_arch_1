	# Função strcpy() (string copy) copia uma string residente numa zona de memória para 
	# outra  zona  de  memória.  A  função  aceita  como  argumentos  um  ponteiro  para  a  string  de 
	# origem (src) e um ponteiro para a zona de memória destino (dst). A função devolve ainda 
	# o ponteiro dst com o mesmo valor que foi passado como argumento.
	# O argumento da função é passado em $a0 e $a1
	# O resultado é devolvido em $v0 
	# Sub-rotina terminal: não devem ser usados registos $sx
				# Mapa de registos:
				# *dst: $a0
				# *src: $a1
				# p: $t0
				# *p: $t1
				# Temp1: $t3
	.text
	.globl strcpy_p
strcpy_p:
	move $t0,$a0		# p1 = dst; 
	move $t2,$a1		# p2 = src; 
do:				# do { 
  	lb $t3,0($t2)		# $t3 = *p2
  	sb $t3,0($t0)    	# *p1 = *p2; 
  	
  	addiu $t2,$t2,1		# p2++;
  	addiu $t0,$t0,1		# p1++;
while:	bne $t3,'\0',do		# } while(src[i++] != '\0'); 
 	move $v0,$a0		# return dst;
 	jr $ra			# Fim da função strcpy