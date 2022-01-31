	# A função median calcula a mediana dos valores de um array de reais
	# codificado em precisão dupla (A mediana é o valor q separa a metade maior da menor)
	# Habilitar "assemble all files in directory" setting
	# Sub-rotina terminal: não devem ser usados registos $sx ou $f20...
	# Parâmetros de entrada Double são enviados nos registos $f12 - $f15
	# Valores de retorno Double nos registos $f0 - $f3
	# double median(double *array, int nval) {
				# Mapa de registos:
				# *array: $a0
				# nval: $a1
				# houveTroca: $t0
				# i: $t1
				# double aux: $f0
				
	.eqv TRUE,1
	.eqv FALSE,0
	.text
	.globl median
median:
do:				# {
	li $t0,FALSE		# houveTroca = FALSE;
	li $t1,0		# i = 0;
	sub $t2,$a1,1		# $t2 = nval-1
for:	bge $t1,$t2,endfor	# for( i = 0; i < nval-1; i++ ) {
	
	sll $t3,$t1,3		# $t3 = i << 3;
	addu $t3,$t3,$a0	# $t3 = &array[i]
	l.d $f2,0($t3)		# $f2 = array[i]
	
	addi $t3,$t1,1		# $t3 = i + 1
	sll $t3,$t3,3		# $t3 = i << 3;
	addu $t3,$t3,$a0	# $t3 = &array[i+1]
	l.d $f4,0($t3)		# $f2 = array[i+1]
	
	
if:	c.le.d $f2,$f4		# if( array[i] > array[i+1] )
	bc1t endif		# {

	mov.d $f0,$f2		# aux = array[i];
	
	sll $t3,$t1,3		# $t3 = i << 3;
	addu $t3,$t3,$a0	# $t3 = &array[i]
	s.d $f4,0($t3)		# array[i] = array[i+1];
	
	addi $t3,$t1,1		# $t3 = i + 1
	sll $t3,$t3,3		# $t3 = i << 3;
	addu $t3,$t3,$a0	# $t3 = &array[i+1]
	s.d $f0,0($t3)		# array[i+1] = aux;
	li $t0,TRUE		# houveTroca = TRUE;
endif:				# }
	addi $t1,$t1,1		# i++;
	j for
endfor:				# }


while:	beq $t0,1,do		# } while( houveTroca == TRUE );
	
	div $t3,$a1,2		# $t3 = nval / 2
	sll $t3,$t3,3		# $t3 = $t3 << 3;
	addu $t3,$t3,$a0	# $t3 = &array[nval / 2]
	l.d $f0,0($t3)		# return array[nval / 2];
	
	jr $ra			# Fim do programa
