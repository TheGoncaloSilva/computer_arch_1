	.data
str1: 	.asciiz "Uma string qualquer"	# Come�a: 0x10010000
str2: 	.asciiz "AC1 � P"		# Come�a: 0x10010014
	.text
	.globl main
main: 	jr $ra