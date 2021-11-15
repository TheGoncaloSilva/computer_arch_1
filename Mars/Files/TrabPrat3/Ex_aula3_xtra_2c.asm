# 16 bit values - A 16-bit register can store a positive number between 0 and 216 ? 1, that is, 65,535.
# Thus a 16-bit word can be used for positive numbers in the range 0 to 65,535.
# Para testar, calcular valor^2 na calculadora

					# Mapa de Variáveis
					# $t0 - res
					# $t1 - i
					# $t2 - mdor
					# $t3 - mdo
					# $t4 - Temp1
	.data
str1:	.asciiz "Introduza dois numeros: "
str2:	.asciiz "Resultado: "
	.eqv READ_INT, 5
	.eqv PRINT_INTU10, 36
	.eqv PRINT_STRING, 4
	.text
	.globl main
	
main: 
	la $a0,str1			# print_string("...")
	li $v0,PRINT_STRING
	syscall
	
	li $v0,READ_INT			# mdor = read_int()
	syscall
	andi $t2,$v0,0xFFFF		# mdor = mdor & 0x0F (Alterar este parâmetros)
	
	li $v0,READ_INT			# mdor = read_int()
	syscall
	andi $t3,$v0,0xFFFF		# mdo = mdo & 0x0F ((Alterar este parâmetros))
	
for: 	beq $t2,0,endfor		# while((mdor != 0) && (i++ < 16)) { (Alterado de 4 para 16 bits)
	bge $t1,16,endfor
	addi $t1,$t1,1			# i = i + 1
	
	andi $t4,$t2,0x00000001		# Temp1 = mdor & 0x00000001
	
if1:	beq $t4,0,endif1		# if( (Temp1) != 0 ) {
	addu $t0,$t0,$t3			# res = res + mdo
	
endif1:					# }
	sll $t3,$t3,1			# mdo = mdo << 1
	srl $t2,$t2,1			# mdro = mdor >> 1
	j for
endfor:					# }
	la $a0,str2			# print_string("...")
	li $v0,PRINT_STRING
	syscall
	
	move $a0,$t0			# print_string = res
	li $v0, PRINT_INTU10		
	syscall
