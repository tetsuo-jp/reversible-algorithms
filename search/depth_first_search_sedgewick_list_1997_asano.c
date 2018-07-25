#include <stdio.h>
#include <stdlib.h>

typedef struct node *link;
struct node {
    int v;
    link next;
};

link adj[50];
int visited[50];

link new(int v, link next)
{
    link x = malloc(sizeof *x);
    x->v = v; x->next = next;
    return x;
}

void traverse(int k)
{ 
    link t;
    visited[k] = 1;
    printf("%d ", k);
    for (t = adj[k]; t != NULL; t = t->next) {
        if (!visited[t->v]) 
            traverse(t->v);
    }        
}

int main(void)
{
    int i, j, V;
    link t;

    printf("vertex?: ");
    scanf("%d",&V);
        
    // 隣接リスト表現の初期化
    for (i = 0; i < V; i++) {
        adj[i] = NULL;
    }

    while (scanf("%d %d\n", &i, &j) == 2) {
        adj[j] = new(i, adj[j]);
        adj[i] = new(j, adj[i]);
    }
    printf("\n");
  
    for (i = 0; i < V; i++) {
        printf("%d ", i);
        for (t = adj[i]; t != NULL; t = t->next)
            printf("%d ", t->v); 
        printf("\n");
    } 
    printf("\n");
    traverse(0); 
    printf("\n");

    return 0;
}

//////////////////////////////////////////////////////////////////////
// Changelog
// Jul 24, 2018: 浅野さんより 「Sedgewick, R. (1997). Algorithms in C: Parts 1-4, Fundamentals, Data Structures, Sorting, and Searching, Addison-Wesley Longman Publishing Co., Inc.」の日本語版を元にしたとのこと
// Jul 25, 2018: 整形
//////////////////////////////////////////////////////////////////////
