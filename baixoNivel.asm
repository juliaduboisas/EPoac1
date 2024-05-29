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