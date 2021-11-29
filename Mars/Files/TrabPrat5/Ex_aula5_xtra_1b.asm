	# Sequential-sort inteiros ordem crescente (usando ponteiros)
	# (modo signed - para trocar, basta acrescentar u às instruçõs de condição do do while)
				# Mapa de Registos:
				# p: $t0
				# pUltimo: $t1
				# *p: $t2
				# j: $t3
				# jUltimo: $t4
				# *j: $t5
				# aux: $t6
				# Temp1: $t7	
				# Temp2: $t8
	.data
	.eqv SIZE,10
	.eqv TRUE,1
	.eqv FALSE,0
	.eqv READ_INT,5
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
lista:	.space 40 		# SIZE * 4 (espaços da lista têm de ser múltiplos de 4)
	.text
	.globl main
main:	la $t0,lista		# p = &lista[0]
	
	li $t1,SIZE		# pUltimo = SIZE
	subu $t1,$t1,1		# pUltimo = SIZE - 1
	sll $t1,$t1,2		# pUltimo = pUltimo << 2 (i * 4)
	addu $t1,$t1,$t0	# pUltimo = lista + (SIZE - 1)
	
	li $t4,SIZE		# jUltimo = SIZE
	sll $t4,$t4,2		# jUltimo = jUltimo << 2 (i * 4)
	addu $t4,$t4,$t0	# jUltimo = lista + SIZE
	
while1:	bge $t0,$t4,endw1	# while (p < jUltimo) {
	
	li $v0,READ_INT
	syscall			# read_int();
	
	sw $v0,0($t0)		# p = read_int();
	
	addiu $t0,$t0,4		# p += 4
	j while1
endw1:				# }
	
	la $t0,lista		# p = &lista[0]
for1:	bge $t0,$t1,endf1	# for(p=&lista[0]; p < pUltimo; p+=4) {

	addiu $t3,$t0,4		# j = p+1
for2:	bge $t3,$t4,endf2	# for(j = p+1; j < jUltimo; j+=4) {
	
	lw $t2,0($t0)		# $t2 = *p
	lw $t5,0($t3)		# $t5 = *j
	
if:	ble $t2,$t5,endif	# if(*p > *j) {
	move $t6,$t2		# aux = *p
	sw $t5,0($t0)		# p = *j
	sw $t6,0($t3)		# j = aux
endif:				# }
	addiu $t3,$t3,4		# j += 4;
	j for2	
endf2:				# }
	addiu $t0,$t0,4		# p += 4
	j for1
endf1:				# }
	
	la $t0,lista		# p = &lista[0]
while2:	bge $t0,$t4,endw2	# while (p < jUltimo) {
	
	lw $a0,0($t0)		# p = read_int();
	li $v0,PRINT_INT10
	syscall			# print_int10();
	
	li $a0,','
	li $v0,PRINT_CHAR	
	syscall			# print_char(',');
	
	addiu $t0,$t0,4		# p += 4
	j while2
endw2:				# }
	
	