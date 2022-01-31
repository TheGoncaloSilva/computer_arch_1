	
	.text
	.globl main
main:
	li $6,0xFFFFFFF9
	li $7,0x00000002
	div $6,$7
	jr $ra