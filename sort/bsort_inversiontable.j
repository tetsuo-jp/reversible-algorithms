//////////////////////////////////////////////////////////////////////
// bubble sort with optimal intermediate garbage and optimal garbage (inversion table) 
// Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press. p.40
// Knuth, D. E., (1973). TAoCP, Chapter 5
// Tested on http://tetsuo.jp/janus-playground-180405/
//////////////////////////////////////////////////////////////////////

procedure bsort(int in[], int inv[])
  iterate int i = size(in)-1 by -1 to 0
    iterate int j = 0 to i-1
      if in[j+1] < in[j] then
           in[j] <=> in[j+1]
         inv[size(in)-i+j] += 1   // increment inversion table
      fi inv[size(in)-i+j] = size(in)-i
    end
  end  

procedure main()
  int a[5] = {20,50,40,10,30}     // input array
  int inv[5]   // inversion table
  
  call bsort(a,inv)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 25, 2018: Fix layout
//////////////////////////////////////////////////////////////////////