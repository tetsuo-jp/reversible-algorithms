//////////////////////////////////////////////////////////////////////
// counting sort with optimal garbage
// Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press. p.195
//////////////////////////////////////////////////////////////////////

procedure xcopyArray(int s[], int t[], int n)
  local int i = 0
    from  i = 0
    do    t[i] ^= s[i]
          i += 1
    until i = n
  delocal int i = n

procedure csort(int a[], int b[], int c[], int k)
  local int j = 0
    from  j = 0
    loop  c[a[j]] += 1
          j += 1
    until j = size(a)
  delocal int j = size(a)

  local int i = 1
    from  i = 1
    loop  c[i] += c[i-1]
          i += 1
    until i = k
  delocal int i = k

  local int j = size(a) - 1
    from  j = size(a) - 1
    loop  b[c[a[j]]-1] ^= a[j]
          c[a[j]] -= 1
          j -= 1
    until j = 0
  delocal int j = 0

procedure main()
  int a[8] = {2,5,3,0,2,3,0,3}    // input array
  int b[8]     // sorted array
  int c[6]     // distribution
  int k = 6    // the range of elements

  call csort(a,b,c,k)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 25, 2018: Fix layout
//////////////////////////////////////////////////////////////////////