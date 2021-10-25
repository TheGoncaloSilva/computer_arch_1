	.data
	.text
	.globl main
main: 	ori $t0,$0,0xE543 	# substituir val_1 e val_2 pelos
	ori $t1,$0,0xA3E4 	# valores de entrada desejados
	and $t2,$t0,$t1 	# $t2 = $t0 & $t1 (and bit a bit)
	or $t3,$t0,$t1 		# $t3 = $t0 | $t1 (or bit a bit)
	xor $t4,$t0,$t1		# $t4 = $t0 ^ $t1 (xor bit a bit)
	nor $t5,$t0,$t1		# $t5 = ~($t0 | $t1) (nor bit a bit)
	nor $t6,$t0,$t0		# $t6 = ~($t0 | $t0) (not bit a bit)
	jr $ra 			# fim do programa