//////////////////////////////////////////////////////////////////////
// Sedgewick, R. (1997). Algorithms in C: Parts 1-4, Fundamentals, Data Structures, Sorting, and Searching, Addison-Wesley Longman Publishing Co., Inc.
// p.275
//
// Shellsort with garbage
// Tested on http://tetsuo.jp/janus-playground-180405/
//////////////////////////////////////////////////////////////////////

procedure shell_sort(int a[], int sz, stack gb)
  local int h = 1
  from h = 1 do
    local int t = h * 3 + 1
      t <=> h
    delocal int t = h / 3
  until h > sz / 9

  from h > sz / 9 loop
    local int t = h / 3
      t <=> h
    delocal int t = h * 3 + 1
    local int i = h
      from i = h loop
        local int j = i
          local int v = 0
            a[i] <=> v
            from  a[i] = 0
            loop  a[j] <=> a[j-h]
                  j -= h
            until j < h || v > a[j-h]
            a[j] <=> v
          delocal int v = 0
          push(j,gb)
        delocal int j = 0
        i += 1
      until i > sz
      push(i,gb)
    delocal int i = 0
  until h = 1
  delocal int h = 1

procedure main()
  int a[10] = {2,8,7,1,3,5,6,4,0,9}
  int ord[10] = {0,1,2,3,4,5,6,7,8,9}
  int sz = 9
  stack gb

  call shell_sort(a,sz,gb)
  uncall shell_sort(ord,sz,gb)


//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 24, 2018: Fix layout
//////////////////////////////////////////////////////////////////////