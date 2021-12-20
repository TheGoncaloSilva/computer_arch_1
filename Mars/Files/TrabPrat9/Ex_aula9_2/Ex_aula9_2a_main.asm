	# Fun��o main (chama e testa a fun��o f2c)
	# Sub rotina interm�dia, usar os registos $sx para salvaguardar valores inteiros
	# e registos $f20... para salvaguardar valores v�rgula flututante
	# Salvaguardar valor de $ra
	# Incorpora as fun��es presentes no mesmo diret�rio (f2c)
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
				
	.data
	.eqv READ_INT,5
	.eqv PRINT_STRING,4
	.eqv PRINT_DOUBLE,3 	# $v0 = code, $f12 = value_to_print
str1:	.asciiz "Valor em Farenheit: "		
str2:	.asciiz "\nValor em Graus: "
	.text
	.globl main
main:	
	addiu $sp,$sp,-4  	# reserva espa�o na stack
	sw $ra,0($sp)		# salvaguarda $ra
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1)
	
	li $v0,READ_INT
	syscall			# read_int()
	
	mtc1 $v0,$f12		# $f0 = read_int()
	cvt.d.w $f12,$f12	# (float) read_int()
	
	jal f2c			# $f0 = f2c((float)read_int)
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str2)
	
	mov.d $f12,$f0		# $f12 = $f0
	li $v0,PRINT_DOUBLE
	syscall			# print_double(j2c(read_int));
	
	li $v0,0			# return 0;
 	lw $ra,0($sp)		# rep�e o valor de $ra
	addiu $sp,$sp,4		# liberta espa�o da stack
	jr $ra 			# Fim do programa
