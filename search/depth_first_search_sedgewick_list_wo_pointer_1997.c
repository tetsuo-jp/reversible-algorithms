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

int j, x, y, V, E;
struct node *t, *z;
int adj[maxV];
int val[maxV];
int next[maxV];
int available = 0;
void adjlist(void)
{
    scanf("%d %d\n", &V, &E);
    for (j = 1; j <= V; j++) {
        adj[j] = 0;
        val[j] = 0;
        next[j] = 0;
    }
    for (j = 1; j <= E; j++) {
        char v1, v2;
        scanf("%c %c\n", &v1, &v2);
        x = myindex(v1); y = myindex(v2);
        ++available;
        val[available] = x; next[available] = adj[y]; adj[y] = available;
        ++available;
        val[available] = y; next[available] = adj[x]; adj[x] = available;
    }
}


int visited[maxV];

// p.242
void traverse(int k, void (*visit)(int))
{ 
    int t;
    (*visit)(k);
    visited[k] = 1;
    for (t = adj[k]; next[t] != 0; t = next[t]) {
        if (!visited[val[t]]) {
            traverse(val[t], visit);
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
        for (int t = adj[k]; t != 0 && t != next[t]; t = next[t]) {
            printf("%c ", myindex_inv(val[t]));
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

//////////////////////////////////////////////////////////////////////
// Changelog
// Jul 25, 2018: Initial construction
// Jul 27, 2018: Array representation of lists
//////////////////////////////////////////////////////////////////////
