	# A função " max() " determina a média das notas e devolve um ponteiro 
	# para a estrutura que contém os dados do aluno com a nota mais elevada
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina Terminal: Não usar registos $sx ou $f20...
	# student *max(student *st, int ns, float *media) {
				# Mapa de registos:
				# *st: $a0
				# ns: $a1
				# *media: $a2
				# *p: $t0
				# pmax: $t2
				# max_grade: $f0
				# sum: $f2
	.data
max_grade: .float -20.0
sum:	.float 0.0
	.text
	.globl max
max:
	l.s $f0,max_grade	# max_grade = -20.0
	l.s $f2,sum		# sum = 0.0 
	
	move $t0,$a0		# $t0 = p = st;
	mul $t3,$a1,44		# ns = ns * 44 (alinhar à struct student)
	addu $t1,$a0,$t3	# $t1 = st+ns
for:	bgeu $t0,$t1,endf	# for(p = st; p < (st + ns); p++) {
	
	l.s $f4,40($t0)		# $f4 = p->grade
	add.s $f2,$f2,$f4	# sum += $f4
	
if:	c.le.s $f4,$f0		
	bc1t endif		# if(p->grade > max_grade)
	
	mov.s $f0,$f4		# max_grade = p->grade
	move $t2,$t0		# pmax = p;

endif:
	addi $t0,$t0,44		# p++;
	j for
endf:
	mtc1 $a1,$f4		
	cvt.s.w $f4,$f4		# (float)ns;
	div.s $f4,$f2,$f4	# $f4 = sum / (float)ns;
	s.s $f4,0($a2)		# *media = $f4	
	
	move $v0,$t2		# return pmax;

	jr $ra			# Fim da função max
	
