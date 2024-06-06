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

main:

	li $f12, $c				# carrega o valor de c (multiplicando) em $f12
	bne $c, 1.0, multiplicaMatrizReal	# se o valor de c difere de 1, multiplica a matriz
	jal matrizImprime			# imprime a nova matriz
	li $v0, 10				# encerra o progama
	syscall
	

multiplicaMatrizReal:
	
	li $t0, $n					# carrega o valor de n (ordem da matriz) em $t0
	mul $t0, $t0, $t0				# transforma o valor de $t0 no número de itens da matriz
	la $a0, $M					# coloca o ponteiro da matriz em a0
	la $a1, 0					# inicia o contador
	loop:
		ld $f13, ($a0)	    			# carrega o valor apontado pelo a0 para a3
		mul.s $f13, $f13, $f12			# adiciona a3 no valor de a0
		addi $a0, $a0, 4			# aumenta o apontador
		addi $a1, $a1, 1			# aumenta o contador
		blt $a1, $t0, loop			# verifica se terminou e faz o loop

matrizImprime:
 
	# configurações da pilha
	subu  $sp, $sp, 16				# reserva o espaço do frame ($sp)
	sw    $ra, 0($sp)				# salva o endereço de retorno ($ra)
	sw    $fp, 8($sp)				# salva o frame pointer ($fp)
	addiu $fp, $sp, 12				# prepara o frame pointer
	sw    $a0, 0($fp)				# salva o argumento ($a0)
 
	move $s0, $zero					# $s0: contador da linha
	move $s1, $zero					# $s1: contador da coluna
	move $t2, $zero					# $t2: valor a ser lido/armazenado
        
    imprimeMatriz:    
        # calcula o endereço correto do array
        mult     $s0, $t0				# $s2 = linha * numero de colunas
	mflo     $s2					# move o resultado da multiplicação do registrador lo para $s2
	add      $s2, $s2, $s1				# $s2 += contador de coluna
	sll      $s2, $s2, 2				# $s2 *= 4 (deslocamento 2 bits para a esquerda) para deslocamento de byte
    
        # obtem o valor do elemento armazenado
        lw    $t2, M($s2)         
    
        # imprime no console o valor do elemento da matriz
        li     $v0, 4   
        la     $a0, m2
        syscall     
        li     $v0,1    
        move     $a0, $t2
        syscall 
            
	# incrementa o contador
	addi     $t2, $t2, 1 
      
	addi     $s1, $s1, 1			# incrementa contador de coluna
        bne      $s1, $t1, imprimeMatriz	# não é o fim da linha então LOOP
        move     $s1, $zero			# reseta o contador da coluna
        addi     $s0, $s0, 1			# increment row counter
        bne      $s0, $t0, imprimeMatriz	# não é o fim da matriz então LOOP
        jr $ra
        
	# configurações do procedimento    
	add     $v0, $s1, $zero			# retorna para quem chamou    
	jr     $ra
	

.data
	$M:	.word 1, 2
		.word 3, 4
	$n:	2
	$c: .float 1.5
