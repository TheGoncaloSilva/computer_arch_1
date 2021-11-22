			# Mapa de registos
			# i: $t0
			# v:  $t1
			# &(val[0]) = p(val): $t2
			# &val[i]: $t3
			# SIZE / 2: $t4
			# Temp1: $t5
			# Temp2: $t5
	.data
	.eqv SIZE,8
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
	.eqv PRINT_STRING,4
val:	.word 8, 4, 15, -1987, 327, -9, 27, 16
			# array armazenado
str:	.asciiz "Result is: "
	.text
	.globl main
main:
	li $t0,0		# i = 0;
	la $t2,val		# &(val[0])
do1:			# {
	sll $t5,$t0,2	# torna i múltiplo de 4
	addu $t3,$t2,$t5	# v = (&val[0] + i) => val[i]
	lw $t1,0($t3)	# v = val[i];
	li $t4,SIZE
	div $t4,$t4,2	# SIZE = SIZE / 2	
	add $t4,$t4,$t0	# SIZE = (SIZE / 2) + i
	sll $t4,$t4,2	# Tornar SIZE múltiplo de 4
	addu $t5,$t2,$t4	# &Temp1 = &val[0] + (SIZE / 2) + i
	lw $t6,0($t5)	# *Temp2 = &Temp1
	sw $t6,0($t3)	# val[i] = val[i+SIZE/2];
	sw $t1,0($t5) 	# val[i+SIZE/2] = v;
	
	addi $t0,$t0,1	# i++
	li $t4,SIZE
	div $t4,$t4,2	# SIZE = SIZE / 2
while1:	blt $t0,$t4,do1	# } while(++i < (SIZE / 2));
	
	la $a0,str
	li $v0,PRINT_STRING
	syscall		# print_string(str)
	
	li $t0,0		# i = 0;
do2:			# {
	sll $t5,$t0,2	# torna i múltiplo de 4
	addu $t3,$t2,$t5	# &v = (&val[0] + i) => val[i]
	lw $a0,0($t3)	# $a0 = val[i];
	li $v0,PRINT_INT10
	syscall		# print_int10(val[i]);
	
	addi $t0,$t0,1	# i++
	
	li $a0,','
	li $v0,PRINT_CHAR
	syscall		# print_char(',')

while2:	blt $t0,SIZE,do2	# } while(i < SIZE);

	jr $ra
