	# Converte o digito "v" para o respetivo código ASCII 
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não devem ser usados registos $sx
				# Mapa de registos 
				# v: $a0
	.text
	.globl toascii
toascii:
	addiu $a0,$a0,0x30	# v += '0'; 
if:	ble $a0,'9',endif	# if( v > '9' ) {
  	addiu $a0,$a0,7		# v += 7;  // 'A' - '9' - 1 
endif:				# }
 	move $v0,$a0		# return v;  
	jr $ra			# Fim do programa