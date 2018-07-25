//////////////////////////////////////////////////////////////////////
// bubble sort with optimal intermediate garbage and optimal garbage (inversion table) 
// Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press. p.40
// Knuth, D. E., (1973). TAoCP, Chapter 5
// Tested on http://tetsuo.jp/janus-playground-180405/
//////////////////////////////////////////////////////////////////////

procedure bsort(int in[], int inv[], int sz)
  local int i = sz - 1
    from  i = sz - 1 loop
      local int j = 0
        from  j = 0 loop
          if in[j+1] < in[j] then
	     in[j] <=> in[j+1]
             inv[sz-i+j] += 1 // increment inversion table
          fi inv[sz-i+j] = sz - i
          j += 1
        until j = i
      delocal int j = i
      i -= 1
    until i = 0
  delocal int i = 0
  

procedure main()
  int a[5] = {20,50,40,10,30}     // input array
  int sz       // size of array a[]
  int inv[5]   // inversion table
  sz += 5
  
  call bsort(a,inv,sz)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 25, 2018: Fix layout
//////////////////////////////////////////////////////////////////////