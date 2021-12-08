	# Make a magic square, where every row, collumn and diagonal of the square adds up to the number
	# look:
	# Inputs: Random number between 22 and 99 (X)
	# ---------				
	# |A| | | |	A: subtract 20 from X
	# | | |D| |	B: add 1 to A
	# | | | |C|	C: add 1 to B
	# | |B| | |	D: subtract 1 from A
	# ---------
	# Example with X = 51:
	# -------------				
	# |31|1 |12|7 |	
	# |11|8 |30|2 |	
	# |5 |10|3 |33|	
	# |4 |32|6 |9 |	
	# -------------
				# Mapa de registos:
				# A: $t0
				# B: $t1
				# C: $t2
				# D: $t3
				# square: $t4
				# i: $t5
				# &square[i]: $t6
				# square[i]: $t7
				# j: $t8
				# square[j]:$t9
	.data
	.eqv SIZE,16		# SIZE = 4 * 4
	.eqv READ_INT,5
	.eqv PRINT_CHAR,11
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
square:	.word 'A',1,12,7,11,8,'D',2,5,10,3,'C',4,'B',6,9
msg:	.asciiz "*** Welcome to the magic square ***"
msg2: 	.asciiz "\nIntroduce a number between 22 and 99: "
msg3:	.asciiz "Magic Square: \n"
sign:	.asciiz "-------------\n"
	.text
	.globl main
main:	
	la $t4,square		# $t4 = &square[0]
	
	la $a0,msg
	li $v0,PRINT_STRING
	syscall			# print_string(msg);
	
	la $a0,msg2
	li $v0,PRINT_STRING
	syscall			# print_string(msg2);
	
	li $v0,READ_INT
	syscall			# $v0 = read_int();
	
	addi $t0,$v0,-20		# $t0 = A = X - 20
	addi $t1,$t0,1		# $t1 = B = A + 1
	addi $t2,$t1,1		# $t2 = C = B + 1
	addi $t3,$t0,-1		# $t3 = D = A - 1
	
	li $t5,0			# i=0;
for:	bge $t5,SIZE,endf	# for( i = 0; i < 16; i++){
	
	sll $t6,$t5,2		# $t6 = i << 2
	addu $t6,$t4,$t6	# $t6 = square + i
	lw $t7,0($t6)		# $t6 = square[i];
	
if:	bne $t7,'A',elif1	# if( square[i] == 'A' ){

	sw $t0,0($t6)		# square[i] = A
	
	j endif
elif1:	bne $t7,'B',elif2	# } elif( square[i] == 'B' )
	
	sw $t1,0($t6)		# square[i] = B
	
	j endif
elif2:	bne $t7,'C',elif3	# } elif( square[i] == 'C' )
	
	sw $t2,0($t6)		# square[i] = C
	
	j endif
elif3:	bne $t7,'D',endif	# } elif( square[i] == 'D' )
	
	sw $t3,0($t6)		# square[i] = D	

endif:
	
	addi $t5,$t5,1		# i++;
	j for
endf:				# }
	la $a0,msg3
	li $v0,PRINT_STRING
	syscall			# print_string(msg);
	
	la $a0,sign
	li $v0,PRINT_STRING
	syscall			# print_string("-------------");
				
	li $t5,0			# i = 0;
	li $t8,0			# j = 0;
	li $t0,4			# jMax = 0;
for2:	bge $t5,4,endf2		# for( i = 0; i < 4; i++){

	li $a0,'|'
	li $v0,PRINT_CHAR
	syscall
	
for3:	bge $t8,$t0,endf3	# for( j = 0; j < jMax; j++){
	
	sll $t9,$t8,2		# $t9 = j << 2
	addu $t9,$t9,$t4	# $t9 = square + j
	lw $a0,0($t9)		# $t9 = square[j]
	li $v0,PRINT_INT10	
	syscall			# print_int10(square[j]);
	
if2:	bge $a0,10,endif2
	blt $a0,0,endif2		# if(square[j] < 10 && square[j] >= 0){
	
	li $a0,' '
	li $v0,PRINT_CHAR
	syscall			# print_char(' ' );
endif2:				# }
	
	li $a0,'|'
	li $v0,PRINT_CHAR
	syscall			# print_char('|');
	addi $t8,$t8,1		# j++;
	j for3
endf3:				# }
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');
	
	addi $t0,$t0,4		# jMax += 4 (para andar entre 4, 8, 12, 16)
	addi $t5,$t5,1		# i++;
	j for2
endf2:				# }

	la $a0,sign
	li $v0,PRINT_STRING
	syscall			# print_string("-------------");
		
	jr $ra			# Fim do programa
	