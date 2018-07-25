// Iterative factorial
procedure factI(int n, int res)
  res ^= 1
  local int i = 0
      from  i = 0
      loop  i += 1
            local int tmp = res * i
                res <=> tmp
            delocal int tmp = res / i
      until i = n
  delocal int i = n

// Recursive factorial: factR is called exponential times
procedure factR(int n, int res)
  if n = 0 then
    res ^= 1
  else
    n -= 1
    local int tmp = 0
      call factR(n, tmp)
      res ^= (n + 1) * tmp
      uncall factR(n, tmp)
    delocal int tmp = 0
    n += 1
  fi n = 0

procedure main()
  int n
  int res

  n += 5
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