	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não podem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# int abs(int val) {
				# Mapa de registos:
				# val: $a0
	.text
	.globl abs_f
abs_f:
if:	bgez $a0,endif		# if(val < 0) {
	sub $a0,$0,$a0		# val -= val;
endif:				# }
	move $v0,$a0		# return val;	
	jr $ra			# Fim do programa
