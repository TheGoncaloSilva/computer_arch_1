	# A função read_data lê da consola os dados de cada aluno e preenche a 
	# respectiva estrutura. As estruturas estão organizadas num array e
	# utiliza-se acesso indexado. relembre que sizeof(student)=44
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina Terminal: Não usar registos $sx ou $f20...
	# void read_data(student *st, int ns) {
				# Mapa de registos:
				# *st: $a0 -> $t0
				# ns: $a1 -> $t1
				# i: $t2
				# st[i]: $t3
	.data
	.eqv PRINT_STRING,4
	.eqv READ_STRING,8
	.eqv READ_INT,5
	.eqv READ_FLOAT,6
str1:	.asciiz "N. Mec: "
str2: 	.asciiz "Primeiro Nome: "
str3: 	.asciiz "Ultimo Nome: "
str4:	.asciiz "Nota: "
	.text
	.globl read_data
read_data:
	move $t0,$a0		# $t0 = *st
	move $t1,$a1		# $t1 = ns
	li $t2,0		# i=0;
for:	bge $t2,$t1,endfor	# for(i=0; i < ns; i++){

	mul $t3,$t2,44		# $t3 = i * 44
	addu $t3,$t0,$t3	# $t3 = st[i];
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string(str1);
	
	li $v0,READ_INT
	syscall			# $v0 = read_int();
	sw $v0,0($t3)		# st[i].id_number = read_int();
	
	la $a0,str2
	li $v0,PRINT_STRING
	syscall			# print_string(str2);
	
	addiu $t3,$t3,4		# Offset Primeiro Nome
	move $a0,$t3		# $a = buff
	li $a1,17		# $a1 = length
	li $v0,READ_STRING	# read_string(st[i].first_name, 17);
	syscall
	
	la $a0,str3
	li $v0,PRINT_STRING
	syscall			# print_string(str3);
	
	addiu $t3,$t3,18	# Offset Ultimo Nome
	move $a0,$t3		# $a = buff
	li $a1,14		# $a1 = length
	li $v0,READ_STRING	# read_string(st[i].last_name, 14);
	syscall
	
	la $a0,str4
	li $v0,PRINT_STRING
	syscall			# print_string(str4);
	
	addiu $t3,$t3,18	# Offset Grade
	li $v0,READ_FLOAT	
	syscall			# $f12 = read_float();
	s.s $f0,0($t3)		# st[i].grade = read_float();
	
	addi $t2,$t2,1		# i++;
	j for
endfor:				# }

	jr $ra 			# Fim da função read_data
	