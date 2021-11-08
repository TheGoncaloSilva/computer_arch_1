					# Mapa de registos:
					# $t0 – value
					# $t1 – bit
					# $t2 - i
					# $t3 - resto divisão
					# $t4 - operações com a constante 0x30
					# $t5 - Flag
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
	li $t5,0			# Flag = 0
for: 	bge $t2,32,endfor 		# while(i < 32) {

	andi $t1,$t0,0x80000000 	# (instrução virtual) (bit = value & '0x80000000')
	srl $t1,$t1,31			# bit = bit >> 31;

if2:	beq $t5,1,then2			# if(flag == 1 || bit != 0)
	bne $t1,0,then2
	j endif2
then2:					# {
	li $t5,1			# Flag = 1
	li $t4,0x30			# $t4 = 0x30
	add $t1,$t1,$t4			# $t1 = t1 + $t4
	li $v0,print_char		# print_char( + $t1);
	move $a0,$t1			
	syscall
	
endif2:					
	sll $t0,$t0,1			# value = value << 1;
	addi $t2,$t2,1			# i++;
	j for 				# }
	
endfor: 				#
	jr $ra 				# fim do programa
