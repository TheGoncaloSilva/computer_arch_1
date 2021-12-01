	# Programa que lê e imprime a informação relativa aos 
	# argumentos fornecidos no program arguments, info:
		# o número de caracteres de cada um dos argumentos;
		# o número de letras (maiúsculas e minúsculas) de cada um dos argumentos;
		# a string com o maior número de caracteres.
	# Método de acesso ao array por ponteiros
	
				# Mapa de registos:
				# $a0: argc (endereço) -> fica no $t0
				# $a1: argv[] (endereço da primeira) -> fica no $t1
				# p: $t2
				# pUltimo: $t3
				# Temp1: $t4
				# p2: $t5
				# charStat: $t6
				# Minusculas: $t7
				# Maiusculas: $t8
				# MaiorChars: $t9
	.data
	.eqv PRINT_STRING,4
	.eqv PRINT_INT10,1
str1:	.asciiz	"Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
str4: 	.asciiz	"\n - Nr. Caracteres: "
str5: 	.asciiz	"\n - Nr. Maiusculas: "
str6: 	.asciiz	"\n - Nr. Minusculas: "
str7: 	.asciiz	"\n-> Maior Nr. Caracteres: "
	.text
	.globl main
main:	
	move $t0,$a0		# $t0 = argc
	move $t1,$a1		# $t1 = argv[]
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1);
	
	move $a0,$t0
	li $v0,PRINT_INT10
	syscall			# print_int10(argc);
	
	sll $t4,$t0,2		# $t4 = SIZE << 2 (SIZE*4)
	addu $t3,$t1,$t4		# pUltimo = p + SIZE
	
	li $t9,0			# MaiorChars = 0;
	move $t2,$t1		# $t2 = p
while: 	bge $t2,$t3,endw		# while(p < pultimo) {
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string('\nP');
	
	move $a0,$t2
	li $v0,PRINT_INT10	
	syscall			# print_int10(i);
	
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string(': ');
	
	lw $a0,0($t2)		# $a0 = *argv[i]
	li $v0,PRINT_STRING
	syscall			# print_string(argv[i]);
				
				# p é um ponteiro para a palavra, por isso 
				# precisamos de carregar esse valor com o lw
				# e dps temos o valor do ponteiro do ponteiro de p (**p)
	move $t5,$a0		# p2 = **p;
				# Reiniciar variáveis
	li $t6,-1		# charStat = -1; (para descontar o '\0') 
	li $t7,0			# Minusculas = 0;
	li $t8,0			# Maiusculas = 0;
	li $t9,0			# MaiorChars = 0;
	li $t4,1			# p2 = 1; (para ser diferente de '\0', de forma a primeira iteração
				# do while em alternativa poderia ser usado o do-while)
while2:	beq $t4,'\0',endw2	# while(p2 != '\0') {
	lb $t4,0($t5)		# $t4 = **p
	
				# 0x41 = 'A' e 0x5A = 'Z'
if1:	blt $t4,0x41,elif1	# if ( (**p >= 0x41) && (**p <= 0x5A) ) { (É maiuscula)
	bgt $t4,0x5A,elif1
	
	addiu $t8,$t8,1		# Maiusculas++;
	j endif1
				# 0x61 = 'a' e 0x7A = 'z' (somar mais 0x20 às maiusculas)
elif1:	blt $t4,0x61,endif1	# if ( (**p >= 0x61) && (**p <= 0x7A) ) { (É minuscula)
	bgt $t4,0x7A,endif1
	
	addiu $t7,$t7,1		# Minusculas++;	
endif1:				# }
	addiu $t6,$t6,1		# charStat++;
	addiu $t5,$t5,1		# p2++; (soma-se um, por causa de 
				# querermos cada posição individual
				# e para isso usa-se o lb)
	j while2
endw2:				# }

if2:	ble $t6,$t9,endif2	# if ($t4 > $t9) {
	move $t9,$t2		# $t9 = *p; (guardar o ponteiro da maior String,
				# para depois aceder mais abaixo)
endif2:				# }
	
	la $a0,str4
	li $v0,PRINT_STRING
	syscall			# print_string('\n - Nr. Caracteres: ');
	
	move $a0,$t6		# $a0 = charStat
	li $v0,PRINT_INT10
	syscall			# print_int10(charStat);
		
	la $a0,str5
	li $v0,PRINT_STRING
	syscall			# print_string('\n - Nr. Maiusculas: ');
	
	move $a0,$t8		# $a0 = Maiusculas
	li $v0,PRINT_INT10
	syscall			# print_int10(Maiusculas);
	
	la $a0,str6
	li $v0,PRINT_STRING
	syscall			# print_string('\n - Nr. Minusculas: ');
	
	move $a0,$t7		# $a0 = Minusculas
	li $v0,PRINT_INT10
	syscall			# print_int10(Minusculas);
	
	addiu $t2,$t2,4		# p += 4
	j while
endw:				# }

	la $a0,str7
	li $v0,PRINT_STRING
	syscall			# print_string('\n-> Maior Nr. Caracteres: ');
	
	lw $a0,0($t9)		# $a0 = argv[$t9]
	li $v0,PRINT_STRING
	syscall			# print_string(argv[$t9]);
	
	jr $ra			# Fim do programa
