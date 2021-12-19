	# A  função  print_array()  imprime  os  valores  de  um  array  "a"  de 
	# "n" elementos inteiros.	
	# Sub rotina Terminal, não usar os registos $sx para salvaguardar valores.
	# Habilitar "assemble all files in directory" setting
	# void print_array(int *a, int n) {
				# Mapa de registos:
				# *a: $a0
				# n: $a1
				# p: $t0
				# a: $t1
	.data
str:	.asciiz ", "
	.eqv PRINT_INT10,1
	.eqv PRINT_STRING,4
	.text
	.globl print_array
print_array:
	move $t1,$a0		# a = *a
	sll $t0,$a1,2		# p = n << 2
	addu $t0,$t0,$t1	# p = n + a

for: 	bge $t1,$t0,endf		# for(; a < p; a++) {
	lw $a0,0($t1)
	li $v0,PRINT_INT10
	syscall			# print_int10(*a);
	
	la $a0,str
	li $v0,PRINT_STRING
	syscall			# print_string(", ")
	
	addiu $t1,$t1,4		# a++; (array de inteiros)
	j for
endf:	
	jr $ra			# Fim do programa