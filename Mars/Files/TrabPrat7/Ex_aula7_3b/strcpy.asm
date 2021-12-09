	# un��o strcpy() (string copy) copia uma string residente numa zona de mem�ria para 
	# outra  zona  de  mem�ria.  A  fun��o  aceita  como  argumentos  um  ponteiro  para  a  string  de 
	# origem (src) e um ponteiro para a zona de mem�ria destino (dst). A fun��o devolve ainda 
	# o ponteiro dst com o mesmo valor que foi passado como argumento.
	# O argumento da fun��o � passado em $a0 e $a1
	# O resultado � devolvido em $v0 
	# Sub-rotina terminal: n�o devem ser usados registos $sx
				# Mapa de registos:
				# *dst: $a0
				# *src: $a1
				# i: $t0
				# &dst[i]: $t1
				# &src[i]: $t2
				# Temp1: $t3
	.text
	.globl strcpy
strcpy: 
	li $t0,0 		# i = 0; 
do:				# do { 
	addu $t2,$t0,$a1	# $t2 = &src[i]
	addu $t1,$t0,$a0	# $t1 = &dst[i]
  	lb $t3,0($t2)		# $t3 = src[i]
  	sb $t3,0($t1)    	# dst[i] = src[i]; 
  	
  	addi $t0,$t0,1		# i++;
while:	bne $t3,'\0',do		# } while(src[i++] != '\0'); 
 	move $v0,$a0		# return dst;
 	jr $ra			# Fim da fun��o strcpy
