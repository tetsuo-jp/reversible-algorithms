#include <stdio.h>
#include <stdlib.h>

// Sedgewick, 1990, p.288
int myindex(char c)
{
    if (c == ' ') {
        return 0;
    }
    return c - 'A' + 1;
}

// inverse of myindex
char myindex_inv(int n)
{
    if (n == 0) {
        return ' ';
    }
    return n + 'A' - 1;
}

// Sedgewick, 1990, p.421
#define maxV 1000

struct node {
    int v;
    struct node *next;
};
int j, x, y, V, E;
struct node *t, *z;
struct node *adj[maxV];
void adjlist(void)
{
    scanf("%d %d\n", &V, &E);
    for (j = 1; j <= V; j++) {
        adj[j] = NULL;          /* replaced self-loop back with NULL */
    }
    for (j = 1; j <= E; j++) {
        char v1, v2;
        scanf("%c %c\n", &v1, &v2);
        x = myindex(v1); y = myindex(v2);
        t = (struct node *) malloc(sizeof *t);
        t->v = x; t->next = adj[y]; adj[y] = t;
        t = (struct node *) malloc(sizeof *t);
        t->v = y; t->next = adj[x]; adj[x] = t;
    }
}


int visited[maxV];
typedef struct node *link;

// p.242
void traverse(int k, void (*visit)(int))
{ 
    link t;
    (*visit)(k);
    visited[k] = 1;
    for (t = adj[k]; t != NULL; t = t->next) {
        if (!visited[t->v]) {
            traverse(t->v, visit);
        }
    }        
}

// dummy function
void myvisit(int k)
{
}

void listdfs(void)
{
    int k;
    for (k = 1; k <= V; k++) {
        visited[k] = 0;
    }
    for (k = 1; k <= V; k++) {
        if (visited[k] == 0) {
            traverse(k, myvisit);
        }
    }
}

void print_graph(void)
{
    int k;
    for (k = 1; k <= V; k++) {
        printf("%2d ", visited[k]);
        printf("%c: ", myindex_inv(k));
        for (t = adj[k]; t != z; t = t->next) {
            printf("%c ", myindex_inv(t->v));
        }
        printf("\n");
    }
}

int main(void)
{
    adjlist();
    listdfs();
    print_graph();

    return 0;
}
