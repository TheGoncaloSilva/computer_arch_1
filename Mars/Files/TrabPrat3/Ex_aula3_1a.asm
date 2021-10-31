			# Mapa de registos:
			# $t0 – soma
			# $t1 – value
			# $t2 - i
	.data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz "Valor ignorado\n"
str3: 	.asciiz	"A soma dos positivos e': "
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_int10,36
	.text
	.globl main
main: 	li $t0,0 	# soma = 0;
	li $t2,0	# i = 0;
for: 	b?? $t2,...,endfor # while(i < 5) {
	(...) 		# print_string("...");
	(...)		# value=read_int();
	ble $t1,$0,else # if(value > 0)
	add $t0,... 	# soma += value;
	j ... 		#
else: 	(...) 		# else
			# print_string("...");
endif: addi $t2,... 	# i++;
	j for 		# }
	endfor:
	(...) 		# print_string("...");
	(...) 		# print_int10(soma);
	jr $ra