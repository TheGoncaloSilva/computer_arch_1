	.data
	.text
	.globl main
main: 	ori $a0,$0,8 		# Read input string
	ori $a1,$0,3		# Buffer for String
	syscall 		# chamada ao syscall "read_String()"
	
	or $t0,$0, $a0 		# $t0 = $v0 = valor lido do teclado	
				# (valor de x pretendido)
	or $a0,$0,$t0 		# $a0 = valor lido do teclado
	ori $v0,$0,4		#
	syscall 		# chamada ao syscall "print_Sring()"
				#
	jr $ra 			# fim do programa
