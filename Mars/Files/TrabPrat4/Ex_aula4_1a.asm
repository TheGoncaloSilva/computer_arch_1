# Array de caracteres = array de bytes, cada posição é só uma posição de memória memória do array
				# Mapa de registos
				# num: $t0
				# i: $t1
				# str: $t2
				# str+i: $t3
				# str[i]: $t4
	.data			# representa espaço na memória
	.eqv SIZE,20
	.eqv read_string,8	# $a0 = buf (posição de memória), $a1 = length, $v0 = code
	.eqv print_int10,1	# $a0 = int value
str: 	.space 21		# O assembler não reconhece SIZE+1
				# representa o endereço inicial do espaço para
				# guardar a string na memória externa
				# tamanho máximo da string = SIZE
	.text
	.globl main
main: 	la $a0,str		# $a0=&str[0] (endereço da posição
				# 0 do array, i.e., endereço
				# inicial do array) (carrega o endereço no registo $a0)
	li $a1,SIZE 		# $a1=SIZE
	li $v0,read_string
	syscall		 	# read_string(str,SIZE)
	
	li $t0,0		# num=0;
	li $t1,0		# i=0;
	
while: 	la $t2,str		# carregar o endereço inicial do array
	addu $t2,$t2,$t1	# $t2 = &str[i] (endereço de str[i]) (usar addu para evitar casos de overflow)
	lb $t4,0($t2)		# $t4 = str[i]
	beq $t4,'\0',endw	# while(str[i] != '\0') (é igual 0, $0, '\0'){
	
if: 	blt $t4,'0',endif 	# if(str[i] >= '0' &&
	bgt $t4,'9',endif	# str[i] <= '9');
	addi $t0,$t0,1 		# num++;
endif:
	addi $t1,$t1,1		# i++;
	j while			# }
endw: 	
	move $a0,$t0		# print_int10(num);
	li $v0,print_int10
	syscall
		
	jr $ra 			# termina o programa
