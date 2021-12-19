	# A  função  div  implementa  o  algoritmo  de  divisão  de  inteiros  apresentado  nas  aulas 
	# teóricas (versão otimizada), para operandos de 16 bits
	# Sub rotina Terminal, não usar os registos $sx para salvaguardar valores.
	# Habilitar "assemble all files in directory" setting
	# unsigned int div_int(unsigned int dividendo, unsigned int divisor) {
				# Mapa de registos:
				# dividendo: $a0
				# divisor: $a1
				# i: $t0
				# bit: $t1
				# quociente: $t2
				# resto: $t3
	.text
	.globl div_int
div_int:
	sll $a1,$a1,16		# divisor = divisor << 16
	andi $a0,$a0,0xFFFF	# dividendo = dividendo & 0xFFFF
	sll $a0,$a0,1		# dividendo = (dividendo & 0XFFFF) << 1

	li $t0,0			# i=0	
for:	bge $t0,16,endf		# for(i=0; i < 16; i++) {
	
	li $t1,0			# bit = 0;
if:	bltu $a0,$a1,endif	# if(dividendo >= divisor) {
	subu $a0,$a0,$a1	# dividendo = dividendo - divisor
	li $t1,1			# bit = 1;
endif:				# }
	sll $a0,$a0,1		# dividendo = dividendo << 1
	or $a0,$a0,$t1		# dividendo = (dividendo << 1) | bit;
	
	addi $t0,$t0,1		# i++;
	j for
endf:				# }
	srl $t3,$a0,1		# resto = dividendo >> 1
	andi $t3,$t3,0xFFFF0000	# resto = (dividendo >> 1) & 0xFFFF0000;
	
	andi $t2,$a0,0xFFFF	# quociente = dividendo & 0xFFFF;
	
	or $v0,$t3,$t2		# return(resto | quociente);
	jr $ra			# Fim do programa