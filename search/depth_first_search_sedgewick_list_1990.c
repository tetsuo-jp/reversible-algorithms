//////////////////////////////////////////////////////////////////////
// Sedgewick, R. (1990). Algorithms in C.
// Adjacent list representation
// p.421, p.423
//////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

// p.288
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

// p.421
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
    z = (struct node *) malloc(sizeof *z);
    z->next = z;
    for (j = 1; j <= V; j++) {
        adj[j] = z;
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

// p.423
int val[maxV];
int id = 0;

void visit(int k)
{ 
    struct node *t;
    val[k] = ++id;
    for (t = adj[k]; t != z; t = t->next) {
        if (val[t->v] == 0) {
            visit(t->v);
        }
    }        
}

void listdfs(void)
{
    int k;
    for (k = 1; k <= V; k++) {
        val[k] = 0;
    }
    for (k = 1; k <= V; k++) {
        if (val[k] == 0) {
            visit(k);
        }
    }
}

void print_graph(void)
{
    int k;
    for (k = 1; k <= V; k++) {
        printf("%2d ", val[k]);
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
