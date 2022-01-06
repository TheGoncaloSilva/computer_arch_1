	# A função find_duplicates encontra repetidos num array e maraca-os num array auxiliar
	# Sub rotina terminal, não usar os registos $sx.
	# Habilitar "assemble all files in directory" setting
	# void find_duplicates(int *array, int *dup_array, int size) {
				# Mapa de registos:
				# *array: $a0
				# *dup_array: $a1
				# size: $a2
				# i: $t0
				# j: $t1
				# token: $t2
	.text
	.globl find_duplicates
find_duplicates:

	li $t0,0		# i = 0;
for1: 	bge $t0,$a2,endf1	# for(i=0; i < size; i++) {
	
	sll $t3,$t0,2		# $t3 = i << 2
	addu $t3,$t3,$a1	# $t3 = &dup_array[i]	
	sw $0,0($t3)		# dup_array[i] = 0;
				
	li $t1,0		# j = 0;
	li $t2,1		# token = 1;
for2:	bge $t1,$a2,endf2	# for(j=0, token = 1; j < size; j++)

	sll $t4,$t0,2		# $t4 = i << 2
	addu $t4,$t4,$a0	# $t4 = &array[i]	
	lw $t4,0($t4)		# $t4 = array[i];
	
	sll $t5,$t1,2		# $t5 = j << 2
	addu $t5,$t5,$a0	# $t5 = &array[j]	
	lw $t5,0($t5)		# $t5 = array[j];

if: 	bne $t4,$t5,endif	# if(array[i] == array[j]) {
	sw $t2,0($t3)		# dup_array[j] = token;
	addi $t2,$t2,1		# token++;
	
endif:				# }
	addi $t1,$t1,1		# j++;
	j for2
endf2:				# }
	addi $t0,$t0,1		# i++;
	j for1			
endf1:				# }
	jr $ra			# Fim do programa



				