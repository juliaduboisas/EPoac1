### DUPLA: 28
### ALUNO 1: Júlia Du Bois Araújo Silva		14584360
### ALUNO 2: Marcos Medeiros da Silva Filho	14594271
### EXERCÍCIO 27

### ENUNCIADO:
# Dada uma matriz real quadrada A de ordem n e um inteiro positivo k,define-se a aproximação
# da matriz real e^A pela soma abaixo:
# e^A = In + A + (A^2 / 2!) + (A^3 / 3!) + ... + (A^k / k!)
# sendo In a matriz identidade de ordem n.
# (a) Faça uma função que recebe como parâmetros um inteiro n e duas matrizes quadradas reais
# X e Y de ordem n. Esta função devolve em uma matriz Z, também passada como parâmetro, a soma
# das matrizes X e Y.
# (b) Escreva uma função que recebe como parâmetro um número inteiro n, um número real c e
# uma matriz Xnxn. A função devolve em uma matriz Y, também passada como parâmetro, o produto
# do número c pela matriz X. Ou seja, 
# Yij = c * Xij para 0<=i<=n-1 e 0<=j<=n-1
# (c) Escreva uma função que recebe como parâmetros um inteiro n e duas matrizes quadradas
# reais Xnxn e Ynxn. Esta função devolve em uma matriz Z, também passada como parâmetro, o
# produto das matrizes X e Y.
# (d) Faça um programa que, dados dois inteiros n e k e uma matriz real quadrada Anxn, determina
# uma aproximação da matriz real e^A utilizando *obrigatoriamente* as três funções mencionadas
# anteriormente.

### B

.data
	error: .asciiz "Nao eh possivel realizar a operacao"		## Mensagem de erro
	fator: .double 3.0							## Constante da multiplicação
	m1: .double 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0		## Matriz teste NxN
	n: .word 3							## Dimensão da matriz
	dbl_size: .word 8						## Tamanho de um double
	format: .asciiz " "
	newline: .asciiz "\n"

.text
.globl main
main:
addMatriz:
	lw $t1, n			## Carrega a dimensão n das matrizes
	blt $t1, 2, exception 		## Se matriz inválida, não executa procedimento
	lw $t2, dbl_size		## Carrega o tamanho do double
	mul $t3, $t1, $t1		## (n*n)
	mul $t3, $t3, $t2		## (n*n)*dbl_size
	jal alocation			## Aloca dinamicamente a matriz resultante
	li $s0, 0			## i = 0
	li $s1, 0			## j = 0
	la $a0, m1			## Enderenço base da matriz M1
	l.d $f4, fator			## Carrega o valor de c
	L1:
	   li $s1, 0	
	   L2:
	      mul $t5, $s0, $t1		## i*n
	      addu $t5, $t5, $s1	## (i*n) + j
	      mul $t5, $t5, $t2 	## [(i*n) + j]*dbl_size
	      addu $t6, $a0, $t5	## m1[i][j]
	      l.d $f2, ($t6)
	      mul.d $f2, $f2, $f4	## m1[i][j] * c
	      addu $t6, $t4, $t5 	## x[i][j]
	      s.d $f2, ($t6)		## x[i][j] = m1[i][j] * c
	      addi $s1, $s1, 1
	      blt $s1, $t1, L2		## se j < n, repita o processo
	   addi $s0, $s0, 1
	   blt $s0, $t1, L1		## se x < n, repita o processo
	jal print			## imprime a matriz x
	j end

print:
	li $s0, 0
	li $s1, 0
	addi $sp, $sp, -4		## desloca o armazenamento necessario na pilha
	sw $ra, ($sp)			## armazena o endereço de retorno na pilha
	K1:
	  li $s1, 0	
	   K2:
	      mul $t5, $s0, $t1
	      addu $t5, $t5, $s1
	      mul $t5, $t5, $t2
	      addu $t6, $t4, $t5
	      l.d $f12, ($t6)
	      li $v0, 3			## imprime x[i][j]
	      syscall
	      la $a0, format
	      li $v0, 4			## imprime espacamento
	      syscall
	      addi $s1, $s1, 1
	      blt $s1, $t1, K2
	      jal nextline		## imprime \n
	  addi $s0, $s0, 1
	  blt $s0, $t1, K1
	lw $ra, ($sp) 			## devolve o endereço de retorno
	addi $sp, $sp, 4
	jr $ra

nextline:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	la $a0, newline
	li $v0, 4			##imprime \n
	syscall
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	
alocation:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	li $v0, 9			## aloca matriz x dinamicamente
	move $a0, $t3			## matriz com n*n elementos
	syscall
	move $t4, $v0			## transfere o endereço base da matriz x
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
end:
	li $v0, 10			## encerra o programa
	syscall	
exception:
	la $a0, error
	li $v0, 4			## exibe mensagem de erro
	syscall
	j end				
	
