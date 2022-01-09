	# Função main (preenche um array e chama e testa a funçãoo find_duplicates)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# i: $t0
				# dup_counter: $t1
				# &array[0]: $t2
				# &aux_array[0]: $t3
	.data
	.eqv SIZE,10
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
	.eqv READ_INT,5
str1: 	.asciiz "array["
str2:	.asciiz	"]="
str3:	.asciiz "*, "
str4: 	.asciiz ", "
str5: 	.asciiz "\n# repetidos:"
	.align 2
array:	.space 40		# static int array[SIZE]; (array de inteiros, 4 * tamanho)
aux_array:.space 40		# static int aux_array[SIZE];
	.text
	.globl main
main:
	addiu $sp,$sp,-4	# Salvaguardar os valores
	sw $ra,0($sp)		# Salguardar o valor de $ra
	
	la $t2,array		# $t2 = &array[0];
	la $t3,aux_array	# $t3 = &aux_array[0];
	
	# Preencher o array de inteiros
	li $t0,0
for1:	bge $t0,SIZE,endf1	# for(i=0; i < SIZE; i++) {
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string("array[");
	
	move $a0,$t0
	li $v0,PRINT_INT10
	syscall			# print_int10(i);
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string("]=");
	
	li $v0,READ_INT
	syscall			# $v0 = read_int();
	
	sll $t4,$t0,2		# $t4 = i << 2
	addu $t4,$t4,$t2	# $t4 = &array[0] + i;
	sw $v0,0($t4)		# array[i] = read_int();

	addi $t0,$t0,1		# i++;
	j for1
endf1:				# }

	la $a0,array		# $a0 = array
	la $a1,aux_array	# $a1 = aux_array
	li $a2,SIZE		# $a2 = SIZE
	jal find_duplicates	# find_duplicates(array, aux_array, SIZE);

	
	# Imprime array com * nos elementos repetidos
	li $t0,0		# i = 0;
	la $t2,array		# $t2 = &array[0];
	la $t3,aux_array	# $t3 = &aux_array[0];
	li $t1,0		# dup_counter = 0;
for2:	bge $t0,SIZE,endf2	# for(i=0; i < SIZE; i++) {
	
	sll $t4,$t0,2		# $t4 = i << 2
	addu $t4,$t4,$t3	# $t4 = &aux_array[0] + i;
	lw $t4,0($t4)		# $t4 = aux_array[i];
	
if:	blt $t4,2,else		# if(aux_array[i] >= 2) {

	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string("*, ");
	
	addi $t1,$t1,1		# dup_counter++;
	j endif
else:				# } else {
	sll $t4,$t0,2		# $t4 = i << 2
	addu $t4,$t4,$t2	# $t4 = &array[0] + i;
	lw $a0,0($t4)		# $a0 = array[i];
	li $v0,PRINT_INT10
	syscall			# print_int10(array[i]);
	
	la $a0,str4
	li $v0,PRINT_STRING
	syscall 		# print_string(", ");

endif:				# }
	addi $t0,$t0,1		# i++;
	j for2
endf2:				# }	
	
	la $a0,str5
	li $v0,PRINT_STRING
	syscall			# print_string("\n# repetidos: ");
	
	move $a0,$t1
	li $v0,PRINT_INT10
	syscall			# print_int10(dup_counter);

	li $v0,0		# return 0;
	lw $ra,0($sp)		# repôr $ra
	addiu $sp,$sp,4		# libertar espaço da stack
	jr $ra 			# Fim do programa
