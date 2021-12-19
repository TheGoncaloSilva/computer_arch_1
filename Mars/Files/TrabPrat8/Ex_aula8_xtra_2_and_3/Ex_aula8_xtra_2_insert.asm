	# A função insert() permite inserir a string "src" na string "dst", a partir da posição 
	# "pos". 	
	# Sub rotina Intermédia, usar os registos $sx para salvaguardar valores.
	# Habilitar "assemble all files in directory" setting
	# char *insert(char *dst, char *src, int pos) {
				# Mapa de registos:
				# *dst: $a0 -> $s0
				# *src: $a1 -> $s1
				# pos: $a2 -> $s2
				# len_dst: $s3
				# len_src: $s4
				# i: $s5
				# *p: $s6
				# dst[i + len]: $t0
				# dst[i]/src[i]: $t1
	.text
	.globl insert_char
insert_char:

	addiu $sp,$sp,-32 	# reserva espaço na stack
	sw $ra,0($sp)		# salvaguarda $ra
	sw $s0,4($sp)		# salvaguarda $s0
	sw $s1,8($sp)		# salvaguarda $s1
	sw $s2,12($sp)		# salvaguarda $s2
	sw $s3,16($sp)		# salvaguarda $s3
	sw $s4,20($sp)		# salvaguarda $s4
	sw $s5,24($sp)		# salvaguarda $s5
	sw $s6,28($sp)		# salvaguarda $s6
	
	move $s0,$a0		# $s0 = *dst
	move $s1,$a1		# $s1 = *src
	move $s2,$a2		# $s2 = pos
	
	move $s6,$s0		# *p = dst;
	
	move $a0,$s0		# $a0 = dst
	jal strlen		# strlen(dst)
	move $s3,$v0		# len_dst = strlen(dst)
	
	move $a0,$s1		# $a0 = src
	jal strlen		# strlen(src)
	move $s4,$v0		# len_src = strlen(src)
	
if:	bgt $s2,$s3,endif	# if(pos <= len_dst) {
	move $s5,$s3		# i = len_dst
for1:	blt $s5,$s2,endf1	# for(i = len_dst; i >= pos; i--) {
	
	addu $t1,$s0,$s5	# $t1 = &dst[i]
	lb $t1,0($t1)		# $t1 = dst[i]
	
	add $t0,$s5,$s4		# $t0 = i + len_src
	addu $t0,$s0,$t0	# $t0 = &dst[i + len_src]
	sb $t1,0($t0)		# $t0 = dst[i+len_src]

	addi $s5,$s5,-1		# i--;
	j for1			# }
endf1: 
	li $s5,0			# i = 0;
for2:	bge $s5,$s4,endf2	# for(i = 0; i < len_src; i++) {

	addu $t1,$s1,$s5	# $t1 = &src[i]
	lb $t1,0($t1)		# $t1 = src[i]
	
	add $t0,$s5,$s2		# $t0 = i + pos
	addu $t0,$s0,$t0	# $t0 = &dst[i + pos]
	sb $t1,0($t0)		# $t0 = dst[i+pos]
	
	addi $s5,$s5,1		# i++;
	j for2
endf2:				# }
endif:

	move $v0,$s6		# return p;			
	lw $ra,0($sp)		# repôr $ra
	lw $s0,4($sp)		# repôr $s0
	lw $s1,8($sp)		# repôr $s1
	lw $s2,12($sp)		# repôr $s2
	lw $s3,16($sp)		# repôr $s3
	lw $s4,20($sp)		# repôr $s4
	lw $s5,24($sp)		# repôr $s5
	lw $s6,28($sp)		# repôr $s6
	addiu $sp,$sp,32 	# libertar espaço na stack
	jr $ra			# Fim do programa