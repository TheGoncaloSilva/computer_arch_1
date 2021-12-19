	# A função insert() insere o valor "value" na posição "pos" do "array" de inteiros de 
	# dimensão  "size". 	
	# Sub rotina Terminal, não usar os registos $sx para salvaguardar valores.
	# Habilitar "assemble all files in directory" setting
	# int insert(int *array, int value, int pos, int size) {
				# Mapa de registos:
				# *array: $a0
				# value: $a1
				# pos: $a2
				# size: $a3
				# i: $t0
				# array[i]: $t1
				# array[i+1]: $t2
				# array[pos]: $t3
				# size-1: $t4
	.text
	.globl insert
insert: 

if:	ble $a2,$a3,else 	# if(pos > size) {
	li $v0,1			# return 1;
	jr $ra			# Fim do programa
else:				# } else {
	addi $t0,$a3,-1		# size--;
for:	blt $t0,$a2,endf		# for(i = size-1; i >= pos; i--) {
	
	sll $t1,$t0,2		# array[i] = (i) << 2
	addu $t1,$t1,$a0	# &array[i+1] = i + &array[0]
	lw $t1,0($t1)		# $t1 = array[i]
	
	addi $t2,$t0,1		# array[i+1] = i + 1;
	sll $t2,$t2,2		# array[i+1] = (i+1) << 2
	addu $t2,$t2,$a0	# &array[i+1] = (i+1) + &array[0]
	sw $t1,0($t2)		# array[i+1] = array[i]
	
	addi $t0,$t0,-1		# i--;
	j for
endf:				# }
	sll $t3,$a2,2		# &array[pos] = pos << 2
	addu $t3,$t3,$a0	# &array[pos] = pos + &array[0]
	sw $a1,0($t3)		# array[pos] = value
	
	li $v0,0			# return 0;	
endif:	
	jr $ra			# Fim do programa