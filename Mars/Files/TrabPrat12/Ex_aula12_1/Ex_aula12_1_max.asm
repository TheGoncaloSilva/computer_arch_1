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
	.data
max_grade: .float -20.0
sum:	.float 0.0
	.text
	.globl max
max:
	
	move $t0,$a0		# $t0 = p = st;º
	addu $t1,$a0,$a1	# $t1 = st+ns
for:	bgeu $t0,$t1,endf	# for(p = st; p < (st + ns); p++) {
	
	


	addi $t0,$t0,44		# p++;
	j for
endf:
	



	jr $ra			# Fim da função max
	