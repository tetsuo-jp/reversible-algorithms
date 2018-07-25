// Iterative factorial
procedure factI(int n, int res)
  assert(n>=0)
  res ^= 1
  iterate int i = 1 to n
    local int tmp = res * i
      res <=> tmp
    delocal int tmp = res / i
  end

// Recursive factorial: factR is called linear times
procedure factR(int n, int res)
  if n = 0 then
    res ^= 1
  else
    call factR(n-1, res)
    local int tmp = res * n
      res <=> tmp
    delocal int tmp = res / n
  fi n = 0

procedure main()
  int n = 5
  int res

  call factR(n,res)
  print("The 5-th factorial is...")
  show(res)
  print("====================")
  print("Uncalling factI...")
  uncall factI(n,res)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Jul 13,  2015: First commit
// Jul 25, 2018: Fix layout
//////////////////////////////////////////////////////////////////////