	# Bubble Sort inteiros ordem crescente (usando índices) 
	# (modo signed - para trocar, basta acrescentar u às instruçõs de condição do do while)
				# Mapa de registos
				# houve_troca: $t0
				# p: $t1
				# pUltimo: $t2
				# aux: $t3
				# Temp1: $t4
				# *p: $t5
				
	.data
	.eqv SIZE,10
	.eqv TRUE,1
	.eqv FALSE,0
	.eqv READ_INT,5
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
lista:	.space 40		# espaço tem de ser múltiplo de 4
	.text
	.globl main
main: 				# codigo para leitura de valores
	la $t1,lista		# p = &lista[0]
				# Código ponteiro pUltimo:
	li $t2,SIZE		# pUltimo = SIZE
	subu $t2,$t2,1		# SIZE = SIZE - 1
	sll $t2,$t2,2		# múltiplicar por 4
	addu $t2,$t2,$t1	# pUlimo = Lista + (SIZE - 1)
	
for1:	bgt $t1,$t2,endf1	# for($t1 = lista, $t1 <= $t2, $t1 += 4){
	
	li $v0,READ_INT
	syscall			# read_int();
	
	sw $v0,0($t1)		# lista[p] = read_int();
	
	addiu $t1,$t1,4		# t1 += 4 (soma 4 por causa de ser um ponteiro
				# e para o tornar múltiplo de 4)
	j for1
endf1:				# }

do:				# do {
	li $t0,FALSE		# houve_troca = False
	la $t1,lista		# p = %lista[0]
for2:	bge $t1,$t2,endf2	# for ( p = lista; p < pUltimo, p += 4) {
	
	lw $t5,0($t1)		# $t5 = *p
	lw $t4,4($t1)		# $t4 = *(p+1)
	
if:	ble $t5,$t4,endif	# if (*p > *(p+1))
	move $t3,$t5		# aux = *p
	sw $t4,0($t1)		# *p = *(p+1)
	sw $t3,4($t1)		# *(p+1) = aux	
	li $t0,TRUE		# houve_troca = True
endif:				# }
	
	addiu $t1,$t1,4		# p += 4 (soma 4 por causa de ser um ponteiro
				# e para o tornar múltiplo de 4)
	j for2		
endf2:				# }

enddw:  beq $t0,TRUE,do		# } while( houveTroca==TRUE )
	

	la $t1,lista		# p = lista
for3:	bgt $t1,$t2,endf3	# for($t1 = lista, $t1 <= $t2, $t1 += 4){
	
	lw $a0,0($t1)		# print_int10 = p
	
	li $v0,PRINT_INT10
	syscall			# print_int10();
	
	LI $a0,','
	li $v0,PRINT_CHAR
	syscall			# print_char(',');
	
	addiu $t1,$t1,4		# t1 += 4 (soma 4 por causa de ser um ponteiro
				# e para o tornar múltiplo de 4)
	j for3
endf3:				# }

