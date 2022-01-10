	# A função var cálcula a variância
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina intermédia: podem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double var(double *array, int nval) {
				# Mapa de registos:
				# *array: $a0 -> $s0
				# nval: $a1 -> $s1
				# i: $s2
				# soma: $f20
				# media: $f22
	.data
zero:	.float 0.0
	.text
	.globl var
var:				
	addiu $sp,$sp,-24	# reservar espaço na stack	
	sw $ra,0($sp)		# guardar $ra
	sw $s0,4($sp)		# guardar $s0
	sw $s1,8($sp)		# guardar $s1
	sw $s2,12($sp)		# guardar $s2
	s.s $f20,16($sp)	# guardar $f20
	s.s $f22,20($sp)	# guardar $f22
	
	move $s0,$a0		# $s0 = *array;
	move $s1,$a1 		# $s1 = nval;		

	jal average		# $f0 = average(array, nval);
	cvt.s.d	$f0,$f0		# (float)average(array, nval);
	mov.s $f22,$f0		# media = (float)average(array, nval);
	
	li $s2,0		# i = 0;
	l.s $f20,zero		# soma = 0.0;
for:	bge $s2,$s1,endfor	# for(i=0, soma=0.0; i < nval; i++) {
	
	sll $t0,$s2,3		# $t0 = i << 3
	addu $t0,$s0,$t0	# $t0 = &array[i]
	l.s $f12,0($t0)		# $f12 = array[i]
	sub.s $f12,$f12,$f22	# $f12 = array[i] - media	
	li $a0,2		# $a0 = 2
	jal xtoy		# $f0 = xtoy(array[i] - media, 2);
				
	add.s $f20,$f20,$f0	# soma += xtoy(array[i] - media, 2);
	
	
	addi $s2,$s2,1		# i++;
	j for
endfor:				# }
	mtc1 $s1,$f0		
	div.s $f0,$f20,$f0	# $f0 = soma / nval
	cvt.d.s $f0,$f0		# return (double)soma / nval;	
	
	lw $ra,0($sp)		# repor $ra
	lw $s0,4($sp)		# repor $s0
	lw $s1,8($sp)		# repor $s1
	lw $s2,12($sp)		# repor $s2
	l.s $f20,16($sp)	# repor $f20
	l.s $f22,20($sp)	# repor $f22
	addiu $sp,$sp,24	# libertar o espaço da stack	
	jr $ra			# Fim da função var