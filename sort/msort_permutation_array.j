// mergesort using internally optimal garbage with optimal garbage
// Sedgewick, R. and P. Flajolet (2013).
// An introduction to the analysis of algorithms, 2nd ed.,
// Addison-Wesley Longman Publishing Co., Inc. p.8

procedure merge(int a[], int l, int m, int r, int p[])
  local int b[r-l+1]={0}, int c[r-l+1]={0}, int p_b[r-l+1]={0}, int p_c[r-l+1]={0}
    iterate int k = l to m
      b[k-l] <=> a[k]
      p_b[k-l] <=> p[k]
    end
    iterate int k = m+1 to r
      c[k-m-1] <=> a[k]
      p_c[k-m-1] <=> p[k]
    end

    b[m-l+1] ^= 999
    c[r-m] ^= 999 // set sentinel

    local int i = 0, int j = 0
      iterate int k = l to r
        if c[j] < b[i] then
          a[k] <=> c[j]
          p[k] <=> p_c[j]
          j += 1
        else
          a[k] <=> b[i]
          p[k] <=> p_b[i]
          i += 1
        fi p[k] > m
      end
    delocal int i = m-l+1, int j = r-m
    
    b[m-l+1] ^= 999
    c[r-m] ^= 999  // zero clear sentinel
  delocal int b[r-l+1]={0}, int c[r-l+1]={0}, int p_b[r-l+1]={0}, int p_c[r-l+1]={0}

procedure msort_sub(int a[], int l, int r, int p[])
  if l < r then
    call msort_sub(a,l,(l+r)/2,p)
    call msort_sub(a,(l+r)/2+1,r,p)
    call merge(a,l,(l+r)/2,r,p)
  fi l < r

procedure msort(int a[], int p[])
  call msort_sub(a,0,size(a)-1,p)

procedure main()
  int a[8] = {50,20,40,70,10,30,20,60}  // input array, p.35
  int p[8] = {0,1,2,3,4,5,6,7}          // order

  call msort(a,p)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 25, 2018: Fix layout
//////////////////////////////////////////////////////////////////////