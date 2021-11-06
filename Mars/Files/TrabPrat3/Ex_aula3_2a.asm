					# Mapa de registos:
					# $t0 – value
					# $t1 – bit
					# $t2 - i
	.data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz ...
	.eqv print_string,4
	.eqv read_int,...
	.eqv print_char,...
	.text
	.globl main
main: 	la $a0,str1
	li $v0,print_string 		# (instrução virtual)
	syscall 			# print_string(str1);
	(...) 				# value=read_int();
	(...) 				# print_string("...");
	li $t2,0 			# i = 0
for: 	b?? $t2,...,endfor 		# while(i < 32) {
	andi $t1,...,0x80000000 	# (instrução virtual)
	b?? $t1,$0,else 		# if(bit != 0)
	(...) 				# print_char('1');
else: 					# else
	(...) 				# print_char('0');
					# value = value << 1;
					# i++;
	j for 				# }
	endfor: 			#
	jr $ra 				# fim do programa