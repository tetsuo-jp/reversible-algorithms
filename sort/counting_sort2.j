//////////////////////////////////////////////////////////////////////
// Reversible counting sort with input as garbage
// Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press. p.195
// Cormen, T. H., et al. (2022). Introduction to Algorithms fourth edition, The MIT Press. p.209
//////////////////////////////////////////////////////////////////////

procedure csort(int a[], int b[], int c[])
  iterate int j = 0 to size(a)-1
    c[a[j]] += 1
  end
  // c[i] now contains the number of elements equal to i.

  iterate int i = 1 to size(c)-1
    c[i] += c[i-1]
  end
  // c[i] now contains the number of elements less than or equal to i.
  // Copy A to B, starting from the end of A.

  iterate int j = size(a) - 1 by -1 to 0
    b[c[a[j]]-1] ^= a[j]
    c[a[j]] -= 1 // to handle duplicate values
  end

procedure clearc(int a[], int b[], int c[])
  iterate int i = size(c)-1 by -1 to 1
    c[i] -= c[i-1]
  end
  // c[i+1] now contains the number of elements equal to i, except c[size(c)-1]=0.

  iterate int j = 0 to size(a)-1
    if a[j] < size(c)-1 then
      c[a[j]+1] -= 1
    fi a[j] < size(c)-1
  end

procedure main()
  int a[8] = {2,5,3,0,2,3,0,3}    // input array
  // int a[8] = {5,5,3,0,2,3,0,3}    // input array
  int b[size(a)]  // sorted array
  int k = 6       // the range of elements
  int c[k]        // distribution

  call csort(a,b,c)
  call clearc(a,b,c)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 25, 2018: Fix layout
// Apr 18, 2023: Use "iterate" loops, zero clear intermediate garbage array c, add comments, and delete procedure xcopyArray
//////////////////////////////////////////////////////////////////////