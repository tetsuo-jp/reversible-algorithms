//////////////////////////////////////////////////////////////////////
// Bubble sort with optimal garbage
// garbage is stored in an array
//
// Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press. p.40
// Tested on http://tetsuo.jp/janus-playground-180405/
//////////////////////////////////////////////////////////////////////

procedure bsort(int in[], int gb[], int gb_sp)
  iterate int i = 0 to size(in)-1
    iterate int j = size(in)-1 by -1 to i+1
      if in[j] < in[j-1] then
        in[j-1] <=> in[j]
          gb[gb_sp] ^= 1
        else
          gb[gb_sp] ^= -1
        fi gb[gb_sp] = 1
        gb_sp += 1
    end
  end

procedure main()
  int a[6] = {50,20,40,60,10,30}    // input array
  int gb[20]   // garbage stack
  int gb_sp    // garbage stack pointer
  int ord[6] = {0,1,2,3,4,5} // permutation

  call bsort(a,gb,gb_sp)
  uncall bsort(ord,gb,gb_sp)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 24, 2018: Fix layout
//////////////////////////////////////////////////////////////////////