					# Mapa de registos:
					# $t0 – value
					# $t1 – bit
					# $t2 - i
					# $t3 - resto divisão
	.data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz "\nO valor em binário e':"
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_char,11
	.text
	.globl main
main: 	la $a0,str1
	li $v0,print_string 		# (instrução virtual)
	syscall 			# print_string(str1);
	
	li $v0,read_int
	syscall
	move $t0,$v0			# value=read_int();
	
	la $a0,str2			# print_string("...");
	li $v0,print_string
	syscall
	
	li $t2,0 			# i = 0
for: 	bge $t2,32,endfor 		# while(i < 32) {
	
	rem $t3,$t2,4			# $t0 = $t1 % 4
if1:	bne $t3,0,endif1		# if(($t2 % 4) == 0) // resto da divisão inteira
	
	li $v0,print_char		# print_char(' ');
	li $a0,' '			
	syscall
	
endif1: 

	andi $t1,$t0,0x80000000 	# (instrução virtual) ($t1 = $t0 & '0x80000000')
	
if2:	beq $t1,$0,else 		# if(bit != 0)

	li $v0,print_char		# print_char('1');
	li $a0,'1'			
	syscall
	j endif2
	
else: 					# else
	li $v0,print_char		# print_char('0');
	li $a0, '0'			
	syscall
	
endif2:	
	sll $t0,$t0,1			# value = value << 1;
	addi $t2,$t2,1			# i++;
	j for 				# }
	
endfor: 				#
	jr $ra 				# fim do programa
