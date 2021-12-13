	# A  fun��o  itoa()  determina  a  representa��o  do  inteiro  "n" 
	# na base "b" (b pode variar entre 2 e 16),  colocando o resultado no array  de carateres "s", 
	# em  ASCII.  Esta  fun��o  utiliza  o  m�todo  das  divis�es  sucessivas  para  efetuar  a  convers�o 
	# entre  a  base  original  e  a  base  destino  "b":  por  cada  nova  divis�o  �  encontrado  um  novo 
	# d�gito  da  convers�o  (o  resto  da  divis�o  inteira),  esse  d�gito  �  convertido  para  ASCII  e  o 
	# resultado � colocado no array de carateres.  
	# Como  �  conhecido,  neste  m�todo  de  convers�o  o  primeiro  d�gito  a  ser  encontrado  �  o 
	# menos significativo do resultado. Assim, a �ltima tarefa da fun��o itoa() � a chamada  � 
	# fun��o  strrev() para  efetuar  a  invers�o  da  string resultado. 
	# Sub rotina interm�dia, usar os registos $sx para salvaguardar valores
	# Salvaguardar valor de $ra
	# Incorpora as fun��es presentes no mesmo diret�rio (toascii,strrev)
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
	addiu $sp,$sp,-20	# reserva espa�o na stack
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
	lw $ra,0($sp)		# rep�r $ra
	lw $s0,4($sp)		# rep�r $s0
	lw $s1,8($sp)		# rep�r $s1
	lw $s2,12($sp)		# rep�r $s2
	lw $s3,16($sp)		# rep�r $s3
	addiu $sp,$sp,20		# rep�r espa�o da stack 
	jr $ra			# Fim do programa