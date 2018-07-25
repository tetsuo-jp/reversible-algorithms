//////////////////////////////////////////////////////////////////////
// iterative combination
procedure combI(int n, int r, int res)
  assert(res=0)
  if n >= r && r >= 0 then  // if r is negative, res=0
    res ^= 1
    local int i = 0
      from  i = 0
      loop  local int tmp = res
              res ^= tmp ^ tmp * (n - i)
            delocal int tmp = res / (n - i)
            i += 1
      until i = r
    delocal int i = r

    local int i = r
      from  i = r
      loop  local int tmp = res / i
              res ^= tmp ^ tmp * i
            delocal int tmp = res
            i -= 1
      until i = 0
    delocal int i = 0
  else
    res ^= 0
  fi n >= r && r >= 0

procedure extract(int N, int n, int k, stack S)
  local int comb = 0, int i = n, int j = k
    call combI(i-1,j,comb)
    from  i = n
    loop  if N >= comb then
            local int t = i
              push(t,S)
	    delocal int t = 0
	    N -= comb
	    if i-j >= 1 && j >= 0 then
	      local int t = comb * j / (i-1-j+1)
	        t <=> comb
	      delocal int t = comb * (i-1-j+1) / j
	    else
	      // uncall combI(i-1,j,comb)
	      // j -= 1
	      // call combI(i-1,j,comb)
	      comb ^= 1
	    fi i-j >= 1 && j >= 0
	    j -= 1
          fi !empty(S) && i = top(S)
          if i-1 >= 0 && i-1-j >= 1 then
	    local int t = comb * (i-1-j) / (i-1)
	      t <=> comb
	    delocal int t = comb * (i-1) / (i-1-j)
	  else
	    // uncall combI(i-1,j,comb)
	    // i -= 1
	    // call combI(i-1,j,comb)
	    // show(i,j,comb)
	    comb -= 1
	  fi i-1 >= 0 && i-1-j >= 1
	  i -= 1
    until i = 0
  delocal int comb = 0, int i = 0, int j = 0

procedure rmerge(int Y1[], int n1, int Y2, int Y3[], int n3, int rindex, int L[], int n)
  local stack X = nil
    call extract(rindex, n1+n3, n1, X)
    // show(rindex,n1,n3,X)
    L[0] <=> Y2
    n += 1
    from  n = 1
    do    if !(empty(X)) && n = top(X) then
            local int t = 0
              pop(t,X)
	    delocal int t = n
	    n1 -= 1
            L[n] <=> Y1[n1]
	  else
	    n3 -= 1
	    L[n] <=> Y3[n3]
	  fi L[0] < L[n]
	  // show(n)
	  n += 1
    until n1 = 0 && n3 = 0
  delocal stack X = nil

// iterative factorial
procedure factI(int n, int res)
  res ^= 1
  local int i = 0
    local int tmp = 0
      from  i = 0
      loop  tmp <=> res
            res ^= tmp * (n - i)
            tmp ^= res / (n - i)   // zero clear
            i += 1
      until i = n
    delocal int tmp = 0
  delocal int i = n

procedure qsort(int L[], int n, int rindex)
  if n > 1 then
    local int Y1[n-1] = {0}, int n1 = 0, int Y2 = 0, int Y3[n-1] = {0}, int n3 = 0, int c0 = 0, int c1 = 0, int c2 = 0
      // show(Y1,n1,Y2,Y3,n3,c0,L,n)
      // print("BBB")
      uncall rmerge(Y1,n1,Y2,Y3,n3,c0,L,n)
      // show(Y1,n1,Y2,Y3,n3,c0,L,n)
      // print("AAA")
      call qsort(Y1,n1,c1)
      call qsort(Y3,n3,c2)

      local int fact_Lm1 = 0, int fact_n1 = 0, int fact_n3 = 0
        call factI(n1+n3,fact_Lm1)
        call factI(n1,fact_n1)
	call factI(n3,fact_n3)
        rindex ^= n3 * fact_Lm1 + c0 * fact_n1 * fact_n3 + c1 * fact_n3 + c2
	// show(rindex,n3,n,c0,c1,c2,fact_n1,fact_n3,fact_Lm1)
        // n3 ^= rindex / fact_Lm1                       // zero clear
        c2 ^= rindex % fact_n3	                         // zero clear
        c1 ^= rindex / fact_n3 % fact_n1     // zero clear
        c0 ^= rindex / (fact_n1 * fact_n3) % (fact_Lm1 / (fact_n1 * fact_n3))   // zero clear
	// show(c0,c1,c2)
	uncall factI(n3,fact_n3)
        uncall factI(n1,fact_n1)
        uncall factI(n1+n3,fact_Lm1)
      delocal int fact_Lm1 = 0, int fact_n1 = 0, int fact_n3 = 0

      // Move elements from Y1[], Y2, Y3[] to L[]
      n ^= n1 + 1 + n3
// show(Y1,n1,Y2,Y3,n3,L,n)
      L[n1] <=> Y2
// show(Y1,n1,Y2,Y3,n3,L,n)
      from  n1 + 1 + n3 = n
      loop  n1 -= 1
            L[n1] <=> Y1[n1]
      until n1 = 0
// show(Y1,n1,Y2,Y3,n3,L,n)
      local int i = n - n3, int j = 0
        from  j = 0
        loop  L[i] <=> Y3[j]
              i += 1
	      j += 1
        until j = n3
      delocal int i = n, int j = n3
// show(Y1,n1,Y2,Y3,n3,L,n)
      local int fact_Lm1 = 0
        call factI(n-1,fact_Lm1)
        n3 ^= rindex / fact_Lm1                          // zero clear
        uncall factI(n-1,fact_Lm1)
      delocal int fact_Lm1 = 0
    delocal int Y1[n-1] = {0}, int n1 = 0, int Y2 = 0, int Y3[n-1] = {0}, int n3 = 0, int c0 = 0, int c1 = 0, int c2 = 0
  fi n > 1

procedure main()
  int n = 9
  // int L[n] = {2,4,3,6,7,1,8,5,9}
  int L[n] = {2,4,3,6,77,1,8,5,9}
  int rindex = 0

  // int Y1[n]
  // int n1
  // int Y2
  // int Y3[n]
  // int n3

  call qsort(L,n,rindex)
  // uncall rmerge(Y1,n1,Y2,Y3,n3,N,L,n)
  // uncall rmerge(Y1,n1,Y2,Y3,n3,rindex,L,n)

  // local stack S = nil
  //   call extract(N, 9, 5, S)
  //   show(N,S)
  //   uncall extract(N, 9, 5, S)
  // delocal stack S = nil

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 9,  2015: First commit
// Jul 25, 2018: Fix layout
//////////////////////////////////////////////////////////////////////