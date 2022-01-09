	# A função xoty calcula o valor de x^y , com "x" real e 
	# "y" inteiro (positivo ou negativo)
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina intermédia: podem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# float xtoy(float x, int y) {
				# Mapa de registos:
				# float x: $f12 -> $f20
				# float result: $f22
				# y: $a0 -> $s0
				# i: $t0
				# abs(y): $t1
	.data
n1:	.float 1.0
	.text
	.globl xtoy
xtoy:
	addiu $sp,$sp,-24	# Salvaguardar os valores
	sw $ra,0($sp)		# guardar $ra
	sw $s0,4($sp)		# guardar $s0
	s.s $f20,8($sp)		# guardar $f20
	s.s $f22,16($sp)	# guardar $f22
	
	move $s0,$a0		# $s0 = y;	
	mov.s $f20,$f12		# $f20 = x;
	l.s $f22,n1		# result = 1.0;
	
	jal abs_f		# $v0 = abs_f(y);
	
	move $t1,$v0
	li $t0,0		# i = 0;
for:	bge $t0,$t1,endfor	# for(i=0, result=1.0; i < abs(y); i++){
if:	blez $s0,else		# if(y > 0) {
	mul.s $f22,$f22,$f20	# result *= x;
	j endif			
else:				# } else {
	div.s $f22,$f22,$f20	# result /= x;
endif:				# }
	addi $t0,$t0,1		# i++;
	j for
endfor:				# }

	mov.s $f0,$f22		# return val;

	lw $ra,0($sp)		# guardar $ra
	lw $s0,4($sp)		# guardar $s0
	l.s $f20,8($sp)		# guardar $f20
	l.s $f22,16($sp)	# guardar $f22
	addiu $sp,$sp,24	# repor os valores do stack
	jr $ra 			# Fim do programa