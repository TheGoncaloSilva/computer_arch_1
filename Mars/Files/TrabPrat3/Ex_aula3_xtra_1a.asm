					# Mapa de variáveis
					# $t0 - gray
					# $t1 - bin
					# $t2 - mask
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nValor em código Gray: "
str3:	.asciiz "\nValor em binário: "
	.eqv READ_INT,5
	.eqv PRINT_INT16,34
	.eqv PRINT_STRING,4
	.text
	.globl main
main:
	la $a0,str1			# print_string("...")
	li $v0,PRINT_STRING
	syscall
	
	li $v0, READ_INT		# gray = read_int()
	syscall
	move $t0,$v0
	
	srl $t2,$t0,1			# maks = gray >> 1
	move $t1,$t0			# bin = gray
	
for:	beq $t2,0,endfor		# while(mask != 0) {
	xor $t1,$t1,$t2			# bin = bin ^ mask
	srl $t2,$t2,1			# mask = mask >> 1
	j for
	
endfor:					# }
	la $a0,str2			# print_string("...")
	li $v0, PRINT_STRING		
	syscall
	
	move $a0, $t0			# print_int16(gray)
	li $v0, PRINT_INT16		
	syscall
	
	la $a0,str3			# print_string("...")
	li $v0, PRINT_STRING		
	syscall
	
	move $a0, $t1			# print_int16(bin)
	li $v0, PRINT_INT16		
	syscall
	
	jr $ra 				# Fim do programa