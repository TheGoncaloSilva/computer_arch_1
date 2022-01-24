	# A função " print_student() " imprime (sem grandes cuidados de formatação)
	# os dados de uma instância da estrutura student referenciada pelo ponteiro "p"
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina Terminal: Não usar registos $sx ou $f20...
	# void print_student(student *p) {
				# Mapa de registos:
				# *p = $a0 -> $t0
	.eqv PRINT_INTU10,36
	.eqv PRINT_STRING,4
	.eqv PRINT_FLOAT,2
	.eqv PRINT_CHAR,11
	.text
	.globl print_student
print_student:
	move $t0,$a0		# $a0 = $a0
	lw $a0,0($t0)		# p->id_number
	li $v0,PRINT_INTU10
	syscall			# print_intu10(p->id_number);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char(',')
	
	addiu $t0,$t0,4		# Acertar offset first_name
	move $a0,$t0
	li $v0,PRINT_STRING
	syscall			# print_string(p->first_name);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char(',')
	
	addiu $t0,$t0,18	# Acertar offset last_name
	move $a0,$t0
	li $v0,PRINT_STRING
	syscall			# print_string(p->last_name);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char(',')
	
	addiu $t0,$t0,18	# Acertar offset grade (15 + 3)
	l.s $f12,0($t0)		# p->grade
	li $v0,PRINT_FLOAT
	syscall			# print_float(p->grade);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char(',')
	
	jr $ra			# Fim da função print_Student
