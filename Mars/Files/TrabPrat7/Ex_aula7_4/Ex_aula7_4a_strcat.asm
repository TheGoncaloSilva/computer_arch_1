	# A função strcat() (string concatenate) permite concatenar duas strings – a string origem 
	# é  concatenada  no  fim  (isto  é,  na  posição  do  terminador)  da  string  destino.
	# Os argumentos de entrada são os ponteiros para a string origem (src) e 
	# para a string destino (dst).
	# A função devolve ainda o ponteiro dst com o mesmo valor que 
	# foi passado como argumento. Compete ao programa chamador reservar espaço em memória 
	# com dimensão suficiente para armazenar a string resultante.
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores.
		# Não esquecer de salvaguardar os valores de $sx na stack antes de os alterar
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# *dst: $a0
				# *src: $a1
				# p: $t0
				# Temp1: $t1
	.text
	.globl strcat
strcat:	
	addiu $sp,$sp,-12 	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	sw $s0,4($sp)		# guarda valor dos registos
	sw $a1,8($sp)		# guarda valor dos registos
				# arquitetura "callee-saved" (Própria função salvaguarda os dados)
	move $s0,$a0		# $s0 = dst
	move $s1,$a1		# $s1 = src (guardar os dados de entrada)
	move $t0,$s0		# char *p = dst; 

while:	lb $t1,0($t0)
 	beq $t1,'\0',endw	# while(*p != '\0') 
 	addiu $t0,$t0,1		# p++;
 	j while 
endw:
	move $a0,$t0		# entrada p de strcpy
	move $a1,$s1		# entrada src de strcpy
	jal strcpy		# strcpy(p, src); 
 	
 	move $v0,$s0		# return dst;
	lw $ra,0($sp)		# repõe o valor de $ra
	addiu $sp,$sp,12		# liberta espaço da stack
	jr $ra 			# Fim do programa	
