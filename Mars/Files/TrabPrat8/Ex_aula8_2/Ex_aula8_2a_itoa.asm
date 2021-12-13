	# A  função  itoa()  determina  a  representação  do  inteiro  "n" 
	# na base "b" (b pode variar entre 2 e 16),  colocando o resultado no array  de carateres "s", 
	# em  ASCII.  Esta  função  utiliza  o  método  das  divisões  sucessivas  para  efetuar  a  conversão 
	# entre  a  base  original  e  a  base  destino  "b":  por  cada  nova  divisão  é  encontrado  um  novo 
	# dígito  da  conversão  (o  resto  da  divisão  inteira),  esse  dígito  é  convertido  para  ASCII  e  o 
	# resultado é colocado no array de carateres.  
	# Como  é  conhecido,  neste  método  de  conversão  o  primeiro  dígito  a  ser  encontrado  é  o 
	# menos significativo do resultado. Assim, a última tarefa da função itoa() é a chamada  à 
	# função  strrev() para  efetuar  a  inversão  da  string resultado. 
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as funções presentes no mesmo diretório (toascii,strrev)
	# Habilitar "assemble all files in directory" setting
	# char *itoa(unsigned int n, unsigned int b, char *s) {
				# Mapa de registos:
				# n: $a0 -> $s0
				# b: $a1 -> $s1
				# *s: $a2 -> $s2
				# *p: $s3
				# digit: $t0
	
	.text
	.globl itoa
itoa:	
	addiu $sp,$sp,-20	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguardar $ra
	sw $s0,4($sp)		# salvaguardar $s0
	sw $s1,8($sp)		# salvaguardar $s1
	sw $s2,12($sp)		# salvaguardar $s2
	sw $s3,16($sp)		# salvaguardar $s3
				# arquitetura "callee-saved"
	move $s0,$a0		# $s0 = n
	move $s1,$a1		# $s1 = b
	move $s2,$a2		# $s2 = s
	move $s3,$s2		# *p = s;
do:				# {
	remu $t0,$s0,$s1,	# digit = n % b;
	divu $s0,$s0,$s1	# n = n / b; 
	move $a0,$t0		# entrada de toascii - $a0
  	jal toascii		# toascii( digit );
  	sb $v0,0($s3)		# *p++ = toascii( digit );
	addiu $s3,$s3,1		# p++;
while:	bgtu $s0,0,do		# } while( n > 0 ); (usar o u por causa do inteiro ser unsigned)
	sb $0,0($s3)  		# *p = '\0';
	
	move $a0,$s2		# entrada de strrev = s			
	jal strrev		# strrev(s);

	move $v0,$s2		# return s;
	lw $ra,0($sp)		# repôr $ra
	lw $s0,4($sp)		# repôr $s0
	lw $s1,8($sp)		# repôr $s1
	lw $s2,12($sp)		# repôr $s2
	lw $s3,16($sp)		# repôr $s3
	addiu $sp,$sp,20		# repôr espaço da stack 
	jr $ra			# Fim do programa