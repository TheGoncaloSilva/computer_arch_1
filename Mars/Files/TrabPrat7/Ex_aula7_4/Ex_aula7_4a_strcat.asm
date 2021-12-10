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
	.text
	.globl strcat
strcat:
	