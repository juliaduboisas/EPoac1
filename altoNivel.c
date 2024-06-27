////// DUPLA: 28
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

#define true 1
#define false 0

typedef int bool;


bool addMatriz(int n, double*** x, double*** y, double*** z);
bool mulConstMatriz(int n, double c, double*** x, double*** y);
bool mulMatriz(int n, double*** x, double*** y, double*** z);
bool freeMatriz(int n, double***x);
void copyMatriz(int n, double***x, double***y);
void eAux(int n, int k, double*** a, double*** b, double*** e);
bool matrizE(int n, int k, double*** a, double*** e);

int main(){

    printf("----OAC1----\n");

    double**a =(double**) malloc(sizeof(double*)*3);
    for(int i = 0; i < 3; i++){
        a[i] = (double*) malloc(sizeof(double)*3);
    }
    a[0][0] = 2;
    a[0][1] = 2;
    a[0][2] = 2;
    a[1][0] = 2;
    a[1][1] = 2;
    a[1][2] = 2;
    a[2][0] = 2;
    a[2][1] = 2;
    a[2][2] = 2;

    double** aux;

    addMatriz(3, &a, &a, &aux);
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            printf("%lf ", aux[i][j]);
        }
        printf("\n");
    }
    for(int i = 0; i < 3; i++){
        free(aux[i]);
    }
    free(aux);

    printf("\n");

    mulConstMatriz(3, 3, &a, &aux);
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            printf("%lf ", aux[i][j]);
        }
        printf("\n");
    }
    for(int i = 0; i < 3; i++){
        free(aux[i]);
    }
    free(aux);
    printf("\n");

    mulMatriz(3, &a, &a, &aux);
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            printf("%lf ", aux[i][j]);
        }
        printf("\n");
    }
    for(int i = 0; i < 3; i++){
        free(aux[i]);
    }
    free(aux);
    printf("\n");

    matrizE(3, 3, &a, &aux);
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            printf("%lf ", aux[i][j]);
        }
        printf("\n");
    }
    for(int i = 0; i < 3; i++){
        free(aux[i]);
    }
    free(aux);
    printf("\n");

    return 0;
}

bool addMatriz(int n, double*** x, double*** y, double*** z){
    if(n < 2) return false;
    *z = (double**) malloc(sizeof(double*)*n);
    for(int i = 0; i < n; i++){
        (*z)[i] = (double*) malloc(sizeof(double) * n);
    }
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            (*z)[i][j] = (*x)[i][j] + (*y)[i][j];
        }
    }

    return true;
}

bool mulConstMatriz(int n, double c, double*** x, double*** y){
    if(n < 2) return false;
    *y = (double**) malloc(sizeof(double*)*n);
    for(int i = 0; i < n; i++){
        (*y)[i] = (double*) malloc(sizeof(double)*n);
    }
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            (*y)[i][j] = c * (*x)[i][j];
        }
    }

    return true;
}

bool mulMatriz(int n, double*** x, double*** y, double*** z){
    if(n < 2) return false;
    *z = (double**) malloc(sizeof(double*)*n);
    for(int i = 0; i < n; i++){
        (*z)[i] = (double*) malloc(sizeof(double)*n);
        for(int j = 0; j < n; j++) (*z)[i][j] = 0;
    }
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            for(int k = 0; k < n; k++){
                (*z)[i][j] += (*x)[i][k]*(*y)[k][j];
            }
        }
    }

    return true;
}

bool freeMatriz(int n, double*** x){
    if(n < 2) return false;
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            free((*x)[i]);
        }
    }
    free((*x));
    return true;
}

void copyMatriz(int n, double*** x, double*** y){
    if(n < 2) return;
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            (*y)[i][j] = (*x)[i][j];
        }
    }
}

void eAux(int n, int k, double*** a, double*** b, double*** e){
    if(k == 1){
        double**aux;
        addMatriz(n, e, a, &aux);
        copyMatriz(n,&aux, e);
        freeMatriz(n, &aux);
    }
    else{
        eAux(n, k-1, a, b, e);
        double** aux;
        mulMatriz(n,a,b,&aux);
        copyMatriz(n, &aux, a);
        freeMatriz(n, &aux);
        int fatorial = 1;
        for(int i = 1; i <= k; i++){
            fatorial = fatorial * i;
        }
        double**aux1;
        mulConstMatriz(n, 1.0/fatorial, a, &aux);
        addMatriz(n, &aux, e, &aux1);
        copyMatriz(n,&aux1, e);
        freeMatriz(n, &aux1);
        freeMatriz(n, &aux);
    }
}

bool matrizE(int n, int k, double*** a, double*** e){
    if(n < 2 || k <= 0) return false;
    *e = (double**) malloc(sizeof(double*)*n);
    for(int i = 0; i < n; i++){
        (*e)[i] = (double*) malloc(sizeof(double)*n);
        for(int j = 0; j < n; j++) (*e)[i][j] = 0;
    }
    double** aux;
    addMatriz(n,a,e,&aux);
    eAux(n, k, &aux, a, e);
    return true;

}