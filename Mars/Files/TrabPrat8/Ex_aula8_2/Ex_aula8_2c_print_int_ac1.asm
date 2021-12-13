	# A  fun��o a  implementa  uma  fun��o  para  impress�o  de  um 
	# inteiro atrav�s da utiliza��o da system call print_str() e da fun��o itoa(). Traduza 
	# para assembly esta fun��o e teste-a, escrevendo a respetiva fun��o main(). 
	# Sub rotina interm�dia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as fun��es presentes no mesmo diret�rio (itoa,strrev,toascii)
	# Habilitar "assemble all files in directory" setting
	# void print_int_ac1(unsigned int val, unsigned int base)
				# Mapa de registos:
				# val: $a0 -> $s0
				# base: $a1 -> $s1
	.data
	.eqv PRINT_STRING,4
buf:	.space 33		# static char buf[33];
	.data
	.globl print_int_ac1
print_int_ac1:
	
	la $a2,buf
	jal itoa			# $v0 = itoa(val, base, buf)
	
	move $a0,$v0
	li $v0,PRINT_STRING
	syscall			# print_string( itoa(val, base, buf) ); 
	
	jr $ra			# Fim do programa
		