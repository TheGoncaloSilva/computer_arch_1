			# Mapa de registos
			# ...
			# houve_troca: $t4
			# p: $t5
			# pUltimo: $t6
	.data
	.eqv SIZE,10
	.eqv TRUE,1
	.eqv FALSE,0
	.eqv READ_INT,5
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
lista:	.space 40		# espa�o tem de ser m�ltiplo de 4
	.text
	.globl main
main: 	(...) 		# codigo para leitura de valores
	la $t5,lista 	# $t5 = &lista[0]
	li $t6,SIZE 	#
	subu $t6,$t6,1 	# $t7 = SIZE � 1
	sll $t6,$t6,... 	# $t7 = (SIZE � 1) * 4
	addu $t6,$t6,... 	# $t7 = lista + (SIZE � 1)
do: 	(...) 		# do {
	(...)
