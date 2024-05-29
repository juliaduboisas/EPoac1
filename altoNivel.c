////// DUPLA:
////// ALUNO 1: Júlia Du Bois Araújo Silva		14584360
////// ALUNO 2: Marcos Medeiros da Silva Filho	14594271
////// EXERCÍCIO 27

////// ENUNCIADO:
// Dada uma matriz real quadrada A de ordem n e um inteiro positivo k,define-se a aproximação
// da matriz real e^A pela soma abaixo:
// e^A = In + A + (A^2 / 2!) + (A^3 / 3!) + ... + (A^k / k!)
// sendo In a matriz identidade de ordem n.
// (a) Faça uma função que recebe como parâmetros um inteiro n e duas matrizes quadradas reais
// X e Y de ordem n. Esta função devolve em uma matriz Z, também passada como parâmetro, a soma
// das matrizes X e Y.
// (b) Escreva uma função que recebe como parâmetro um número inteiro n, um número real c e
// uma matriz Xnxn. A função devolve em uma matriz Y, também passada como parâmetro, o produto
// do número c pela matriz X. Ou seja, 
// Yij = c * Xij para 0<=i<=n-1 e 0<=j<=n-1
// (c) Escreva uma função que recebe como parâmetros um inteiro n e duas matrizes quadradas
// reais Xnxn e Ynxn. Esta função devolve em uma matriz Z, também passada como parâmetro, o
// produto das matrizes X e Y.
// (d) Faça um programa que, dados dois inteiros n e k e uma matriz real quadrada Anxn, determina
// uma aproximação da matriz real e^A utilizando *obrigatoriamente* as três funções mencionadas
// anteriormente.


#include <stdio.h>
#include <stdlib.h>

// (a)
float** somaDeMatrizes(int n, float** x, float** y, float** z){
    for(int i = 0; i<n; i++){                   // passa pelas linhas
        for(int j = 0; j<n; j++){               // passa pelas colunas
            z[i][j] = x[i][j] + y[i][j];        // calcula a soma
        }
    }

    return z;                                   // retorna z
}


// (b)
float** multiplicacaoPorNumero(int n, float c, float** x, float** y){
    for(int i = 0; i<n; i++){                   // circula as linhas
        for (int j = 0; j<n; j++){              // circula as colunas
            y[i][j] = x[i][j] * c;              // faz a multiplicacao
        }
    }

    return y;                                   // retorna y
}

//(c)
float** multiplicacaoPorMatriz(int n, float** x, float** y, float** z){
    for(int i = 0; i<n; i++){                   // passa pelas linhas de z
        for(int j = 0; j<n; j++){               // passa pelas colunas de z
            z[i][j] = 0;                        // zera os elementos de z
            for(int k = 0; k<n; k++){           // passa pelos elementos da linha i de x e da coluna j de y
                z[i][j] += x[i][k]*y[k][j];     // calcula o valor do elemento de z
            }
        }
    }

    return z;                                   // retorna z
}

// (d)
int fatorial(int n){                            // função auxiliar que calcula o fatorial de um número n
    if(n==0) return 1;                          // utiliza recursividade
    return fatorial(n-1);
}

int main(){
    int n, k;
    float a[n][n], identidade[n][n], eA[n][n];

    for(int i = 0; i<n; i++){                   // cria a matriz identidade
        for(int j = 0; j<n; j++){
            if(i==j) identidade[i][j]=1;
            else identidade[i][j]=0;
        }
    }

    


}