//////////////////////////////////////////////////////////////////////
// Bubble sort with optimal garbage
// garbage is stored in an array
//
// Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press. p.40
// Tested on http://tetsuo.jp/janus-playground-180405/
//////////////////////////////////////////////////////////////////////

procedure bsort(int in[], stack gb)
  iterate int i = 0 to size(in)-1
    iterate int j = size(in)-1 by -1 to i+1
      if in[j] < in[j-1] then
        in[j-1] <=> in[j]
        push(1,gb)
      else
        push(0,gb)
      fi top(gb) = 1
    end
  end

procedure main()
  int a[6] = {50,20,40,60,10,30}    // input array
  stack gb   // garbage stack
  int ord[6] = {0,1,2,3,4,5} // permutation

  call bsort(a,gb)
  uncall bsort(ord,gb)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 24, 2018: Fix layout
//////////////////////////////////////////////////////////////////////