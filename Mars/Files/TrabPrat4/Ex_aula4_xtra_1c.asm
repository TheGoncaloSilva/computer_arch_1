				# Mapa de registos
				# p: $t0
				# *p: $t1
				# temp1: $t2
				# temp2: $t3
				# temp3: $t4
	.data
	.eqv SIZE,20
	.eqv READ_STRING,8	# $a0 = buf (posição de memória), $a1 = length, $v0 = opcode
	.eqv PRINT_STRING,4	# $a0 = string, $v0 = opcode
hello:	.asciiz "Introduza uma String: "
str:	.space 21		# O assembler não reconhece SIZE+1
				# representa o endereço inicial do espaço para
				# guardar a string na memória externa
				# tamanho máximo da string = SIZE
	.text
	.globl main
main:	
	la $a0,hello		# carregar o registo com o endereço da String
	li $v0,PRINT_STRING	
	syscall			# print_string(hello);
	
	li $a1,SIZE		# length da string = size
	la $a0,str		# $a0 = buf (endereço da posição inicial do array)
	li $v0,READ_STRING
	syscall			# read_string(str,SIZE)
	
	la $t0,str		# p = str
	
while:				
	lb $t1,0($t0)		# *p = str[i]
	beq $t1,0,endw		# while(*p != '\0'){
	
	li $t3,'a'		# carregar para um registo, de forma a ser possível operar
	li $t4,'A'
	
if:	blt $t1,$t3,endif	# if(*p >= 'a' && *p <= 'z'){ (range das minúsculas)
	bgt $t1,'z',endif
	
	subu $t2,$t4,$t3	# temp1 = 'A' - 'a'
				# 'a'=0x61, 'A'=0x41, 'a'-'A'=0x20			
	addiu $t1,$t1,$t2	# *p = *p + ('A'-'a')
endif:				# }
	sb $t1,0($t0)
	addiu $t0,$t0,1		# Percorrer outra posição
	j while
endw:				# }
	la $a0,str		# mover a string para ser imprimida
	li $v0,PRINT_STRING	
	syscall			# print_string(str)
	
	jr $ra
	
	
	
