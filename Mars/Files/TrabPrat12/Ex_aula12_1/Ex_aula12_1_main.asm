	# Função main (chama e testa as funções read_data, max e print_student)
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores inteiros
	# e registos $f20... para salvaguardar valores vírgula flututante
	# Salvaguardar valor de $ra
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Habilitar "assemble all files in directory" setting				
				# Mapa de registos:
	.data
	.eqv MAX_STUDENTS,4
	.eqv PRINT_STRING,4
	.eqv PRINT_FLOAT,2
	.eqv PRINT_CHAR,11
str1:	.asciiz "\nMedia: "
	.align 2

				# typedef struct{
#student:.space 4		# int id_number
#	.space 18		# char first_name[18]
#	.space 15		# char last_name[15]
#	.align 2		# alinhar 37->40
#	.space 4		# float grade
				# } student;
				# Já está alinhado a 44
st_array:.space 176 		# max_students * 4 (44*4)
				# 176 já alinhado a múltiplo de 4 para a media	
media: .space 4			# static float media
				# (Como é static guarda no segmento de dados)
	.text
	.globl main
main:	
	addiu $sp,$sp,-4	# reservar espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	
	la $a0,st_array		# $a0 = st_array
	li $a1,MAX_STUDENTS	# $a1 = MAX_STUDENTS
	jal read_data		# read_data( st_array, MAX_STUDENTS );
	
	la $a0,st_array		# $a0 = st_array
	li $a1,MAX_STUDENTS	# $a1 = MAX_STUDENTS
	la $a2,media		# $a2 = &media (ponteiro de media)
	jal max			# $v0 = max( st_array, MAX_STUDENTS, &media );
	move $t0,$v0		# $t0 = $v0
	
	la $a0,str1
	li $v0,PRINT_STRING
	syscall			# print_string("\nmedia");
	
	l.s $f12,media
	li $v0,PRINT_FLOAT
	syscall			# print_float(media);
	
	li $a0,'\n'
	li $v0,PRINT_CHAR
	syscall			# print_char('\n');

	move $a0,$t0		# $a0 = pmax
	jal print_student	# print_student( pmax );
	
	lw $ra,0($sp)		# repor $ra
	addiu $sp,$sp,4		# libertar o espaço na stack
	jr $ra			# Fim do programa
	
