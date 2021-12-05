				# Mapa de registos
				# val: $t0
				# n: $t1
				# min: $t2
				# max: $t3
	.data
	.eqv READ_INT,5
	.eqv PRINT_STRING,4
	.eqv PRINT_CHAR,11	# $a0 = value
	.eqv PRINT_INT10,1
str1:	.asciiz "Digite até 20 inteiros (zero para terminar) :"
str2:	.asciiz "Máximo/mínimo são: "
	.text
	.globl main
main:	li $t1,0		# n = 0
	li $t2,0x7FFFFFFF	# min = 0x7FFFFFFF
	li $t3,0x80000000	# max = 0x80000000
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1);
	
do:				# {
	li $v0,READ_INT
	syscall			# read_int();
	move $t0,$v0		# val = read_int();
	
if1:	beqz $t0,endif1		# if(val != 0){
if2:	ble $t0,$t3,endif2	# if(val > max)
	move $t3,$t0		# max = val;
endif2:
if3:	bge $t0,$t2,endif1	# if(val < min)
	move $t2,$t0		# min = val;
endif3
endif1:				# }
	
	addi $t1,$t1,1		# n++; 
	
	blt $t1,20,do
while:	bne $t0,0,do		# } while( (n < 20) && (val != 0) );
endw:					
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2);
	
	move $a0,$t3
	li $v0,PRINT_INT10
	syscall			# print_int10(max);
	
	li $a0,':'
	li $v0,PRINT_CHAR
	syscall			# print_char(':');
	
	move $a0,$t2
	li $v0,PRINT_INT10
	syscall			# print_int10(min);
