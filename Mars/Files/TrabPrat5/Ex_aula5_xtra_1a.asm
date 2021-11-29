	# Sequential-sort inteiros ordem crescente (usando índices)
	# (modo signed - para trocar, basta acrescentar u às instruçõs de condição do do while)
				# Mapa de Registos:
				# i: $t0
				# j: $t1
				# aux: $t2
				# lista: $t3
				# lista + i: $t4
				# lista + j: $t5
				# SIZE - 1: $t6
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
main:	la $t3,lista		# $t3 = lista
	
	li $t6,SIZE		# $t6 = SIZE
	addiu $t6,$t6,-1		# $t6 -= 1
	
	li $t0,0			# i = 0;
for1:	bge $t0,SIZE,endf1	# for(i=0; i < SIZE; i++) {

	li $v0,READ_INT
	syscall			# read_int();
	
	sll $t7,$t0,2		# $t7 = i << 2 (i * 4)
	addu $t4,$t3,$t7	# &(lista[i]) = &(lista) + i
	sw $v0,0($t4)		# lista[i] = read_int();
	
	addiu $t0,$t0,1		# i++;
	j for1
endf1:
	
	li $t0,0			# i = 0
for2:	bge $t0,$t6,endf2	# for(i=0; i < SIZE-1; i++) {
	
	sll $t7,$t0,2		# $t7 = i << 2 (i * 4)
	addu $t7,$t3,$t7	# $t7 (&(lista[i])) = &(lista) + i
	lw $t4,0($t7)		# $t4 = lista[i]
	
	addiu $t1,$t0,1		# j = i+1
for3:	bge $t1,SIZE,endf3	# for(j = i+1; j < SIZE; j++) {

	sll $t8,$t1,2		# $t8 = j << 2 (j * 4)
	addu $t8,$t3,$t8	# $t8 (&(lista[j])) = &(lista) + j
	lw $t5,0($t8)		# $t5 = lista[j]

if:	ble $t4,$t5,endif	# if(lista[i] > lista[j]) {

	move $t2,$t4		# aux = lista[i]
	sw $t5,0($t7)		# lista[i] = lista[j}
	move $t7,$t8		# &lista[i] = &lista[j] (Atualizar ponteiro da troca)
	sw $t2,0($t8)		# lista[j] = aux

endif:				# }
	addiu $t1,$t1,1		# j++;
	j for3
endf3:				# }
	addiu $t0,$t0,1		# i++;
	j for2
endf2:				# }

	li $t0,0			# i = 0;
for4:	bge $t0,SIZE,endf4	# for(i=0; i < SIZE; i++) {
	
	sll $t7,$t0,2		# $t7 = i << 2 (i * 4)
	addu $t4,$t3,$t7	# &(lista[i]) = &(lista) + i
	lw $a0,0($t4)		# print_int10 = lista[i];
	
	li $v0,PRINT_INT10
	syscall			# print_int10(lista[i]);
	
	li $a0,','
	li $v0,PRINT_CHAR
	syscall			# print_char(',');
			
	addiu $t0,$t0,1		# i++;
	j for4
endf4:
	
