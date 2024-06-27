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

### C

.data
	error: .asciiz "Nao eh possivel realizar a operacao"		## Mensagem de erro
	m1: .double 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0		## Matriz teste NxN
	m2: .double 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0
	zero: .double 0.0						## auxiliar zero
	n: .word 3 							## dimensão da matriz
	dbl_size: .word 8 						## tamanho  double
	format: .asciiz " "
	newline: .asciiz "\n"
.text
.globl main
main:
mulMatriz:
	lw $t1, n			## Carrega a dimensão da matriz
	blt $t1, 2, exception 		## Se matriz inválida, encerra o programa
	lw $t2, dbl_size 		## Carrega o tamanho double
	mul $t3, $t1, $t1 		## (n*n)
	mul $t3, $t3, $t2 		## (n*n)*dbl_size
	jal alocation 			## aloca matriz dinamicamente
	li $s0, 0 			## i = 0
	li $s1, 0 			## j = 0 
	la $a0, m1 			## endereço base da matriz m1
	la $a1, m2
	##inicializa a matriz
	jal fillZero
	li $s0, 0 			## i = 0
	li $s1, 0 			## j = 0
	li $s2, 0 			## k = 0
	L1:
	  li $s1, 0
	  L2:
	     mul $t5, $s0, $t1
	     addu $t5, $s1, $t5
	     mul $t5, $t5, $t2
	     addu $t6, $t4, $t5 	## x[i][j]
	     li $s2, 0
	     L3:
	        mul $t5, $s0, $t1 	## (i*n)
	        addu $t5, $s2, $t5 	## (i*n) + k
	        mul $t5, $t5, $t2
	        addu $t7, $a0, $t5	## m1[i][k]
	        mul $t5, $s2, $t1 	## (k*n)
	        addu $t5, $s1, $t5 	## (k*n) + j
	        mul $t5, $t5, $t2
	        addu $t8, $a1, $t5 	## m2[k][j]
	        l.d $f2, ($t7)
	        l.d $f4, ($t8)
	        mul.d $f2, $f2, $f4 	## m1[i][k]*m2[k][j]
	        l.d $f4, ($t6)
	        add.d $f2, $f2, $f4 	## x[i][j] += m1[i][k]*m2[k][j]
	        s.d $f2, ($t6)
	        addi $s2, $s2, 1
	        blt $s2, $t1, L3 	## se k < n
	     addi $s1, $s1, 1
	     blt $s1, $t1, L2 		## se j < n
	   addi $s0, $s0, 1
	   blt $s0, $t1, L1 		## se i < n
	 jal impress 			## imprime a matriz x
	 j end 				## finaliza o programa
	 
fillZero:
	##inicializa matriz x
	addi $sp, $sp, -4
	sw $ra, ($sp)
	li $s0, 0
	li $s1, 0
	S1:
	   li $s1, 0
	   S2:
	      mul $t5, $s0, $t1 	## (i*n)
	      addu $t5, $s1, $t5 	## (i*n) + j
	      mul $t5, $t5, $t2 	## [(i*n) +j]*dbl_size
	      addu $t6, $t4, $t5 	## x[i][j]
	      la $t8, zero
	      l.d $f2, ($t8)
	      s.d $f2, ($t6) 		## x[i][j] = 0
	      addi $s1, $s1, 1
	      blt $s1, $t1, S2 		## se j < n, repita o procedimento
	   addi $s0, $s0, 1
	   blt $s0, $t1, S1 		## se i < n, repita o procedimento
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra	     	
impress:
	li $s0, 0
	li $s1, 0
	addi $sp, $sp, -4 		## desloca o armazenamento necessario na pilha
	sw $ra, ($sp) 			## armazena o endereço de retorno na pilha
	K1:
	  li $s1, 0	
	   K2:
	      mul $t5, $s0, $t1
	      addu $t5, $t5, $s1
	      mul $t5, $t5, $t2
	      addu $t6, $t4, $t5
	      l.d $f12, ($t6)
	      li $v0, 3 		## imprime x[i][j]
	      syscall
	      la $a0, format
	      li $v0, 4 		## imprime espacamento
	      syscall
	      addi $s1, $s1, 1
	      blt $s1, $t1, K2
	      jal nextline 		## imprime \n
	  addi $s0, $s0, 1
	  blt $s0, $t1, K1
	lw $ra, ($sp) 			## devolve o endereço de retorno
	addi $sp, $sp, 4
	jr $ra

nextline:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	la $a0, newline
	li $v0, 4 			## imprime \n
	syscall
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	
alocation:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	li $v0, 9 			## aloca matriz x dinamicamente
	move $a0, $t3 			## matriz com n*n elementos
	syscall
	move $t4, $v0 			## transfere o endereço base da matriz x
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
end:
	li $v0, 10 			## encerra o programa
	syscall	
exception:
	la $a0, error
	li $v0, 4 			## exibe mensagem de erro
	syscall
	j end			
