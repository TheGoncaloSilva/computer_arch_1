	# A fun��o strcat() (string concatenate) permite concatenar duas strings � a string origem 
	# �  concatenada  no  fim  (isto  �,  na  posi��o  do  terminador)  da  string  destino.
	# Os argumentos de entrada s�o os ponteiros para a string origem (src) e 
	# para a string destino (dst).
	# A fun��o devolve ainda o ponteiro dst com o mesmo valor que 
	# foi passado como argumento. Compete ao programa chamador reservar espa�o em mem�ria 
	# com dimens�o suficiente para armazenar a string resultante.
	# Sub rotina interm�dia, usar os registos $sx para salvaguardar valores.
		# N�o esquecer de salvaguardar os valores de $sx na stack antes de os alterar
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# *dst: $a0
				# *src: $a1
	.text
	.globl strcat
strcat:
	