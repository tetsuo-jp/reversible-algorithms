//////////////////////////////////////////////////////////////////////
// Depth first search: dfs_rec
//////////////////////////////////////////////////////////////////////

// Assign a new node to "cell"
procedure allocate_object(int elem[], int next[], int flp, int hp, int cell)
  if flp = 0 then
    cell ^= hp
    hp += 1
  else
    local int tmp = next[flp]
      next[flp] ^= tmp
      cell <=> tmp
      next[flp] ^= tmp
    delocal int tmp = next[flp]
    cell <=> flp
  fi flp = 0 && cell = hp - 1

procedure move_next(int elem[], int prev[], int next[], int p)
  local int tmp = next[p]
    p ^= prev[tmp] 	// zero clear
    p <=> tmp
  delocal int tmp = 0

// Search "cell".  If the node is found, its address is stored in zero-cleared "p".
procedure tree_search(int elem[], int parent[], int left[], int right[], int root, int cell, int p)
  p ^= root
  from p = root loop
    if cell <= elem[p] then
      call move_next(elem, parent, left, p)
    else
      call move_next(elem, parent, right, p)
    fi cell <= elem[parent[p]]
  until (cell <= elem[p] && left[p] = 0) || (elem[p] < cell && right[p] = 0)

// Inserting "cell"
// flp: free list pointer
// hp: heap pointer
procedure tree_insert(int elem[], int parent[], int left[], int right[], int root, int flp, int hp, int cell)
  if root = 0 then	// if it is a null tree.
    local int tmp = 0
      call allocate_object(elem, right, flp, hp, tmp)
      root <=> tmp
      elem[root] ^= cell
    delocal int tmp = 0
  else
    local int p = 0
    call tree_search(elem, parent, left, right, root, cell, p)

    // insertion
    local int tmp = 0
      call allocate_object(elem, right, flp, hp, tmp)
      elem[tmp] ^= cell
      parent[tmp] ^= p
      if cell < elem[p] then
        left[p] ^= tmp  tmp ^= left[p]
        call move_next(elem, parent, left, p)
      else
        right[p] ^= tmp
        tmp ^= right[p]
        call move_next(elem, parent, right, p)
      fi cell < elem[parent[p]]
    delocal int tmp = 0

    uncall tree_search(elem, parent, left, right, root, cell, p)
    delocal int p = 0
  fi left[root] = 0 && right[root] = 0 //if it is a tip.

// Depth first search
procedure dfs_rec(int elem[], int parent[], int left[], int right[], int p, int v, int res)
  if v = elem[p] then		//if the element v is found
    res ^= p
  fi v = elem[p]

  if left[p] != 0 then  // executed if there are children
    local int tmp = left[p]	//Search on a left child
      call dfs_rec(elem, parent, left, right, tmp, v, res)
    delocal int tmp = left[p]
  fi left[p] != 0

  if right[p] != 0 then
    local int tmp = right[p]	//Search on a right child
      call dfs_rec(elem, parent, left, right, tmp, v, res)
    delocal int tmp = right[p]
  fi right[p] != 0


// cf. A multiple-array representation of objects, Section 10.3, p.241-, Cormen, T. H., et al. (2009). Introduction to Algorithms third edition, The MIT Press.
procedure main()
  int elem[12]
  int parent[12]
  int left[12]
  int right[12]
  int root // a pointer to the root
  int flp  // a free list pointer
  int hp   // a heap pointer
  int cell
  int p
  int v
  int res

  //initialization
  hp += 1

  //We assume that the same values are inserted more than once.
  call tree_insert(elem, parent, left, right, root, flp, hp, 12)
  call tree_insert(elem, parent, left, right, root, flp, hp, 5)
  call tree_insert(elem, parent, left, right, root, flp, hp, 2)
  call tree_insert(elem, parent, left, right, root, flp, hp, 9)
  call tree_insert(elem, parent, left, right, root, flp, hp, 18)
  call tree_insert(elem, parent, left, right, root, flp, hp, 15)
  call tree_insert(elem, parent, left, right, root, flp, hp, 19)
  call tree_insert(elem, parent, left, right, root, flp, hp, 17)
  call tree_insert(elem, parent, left, right, root, flp, hp, 13)

  //Search a node that has element 15.
  v += 15
  call dfs_rec(elem, parent, left, right, root, v, res)

//////////////////////////////////////////////////////////////////////
// Changelog
// May 14, 2014: Initial construction
// Apr 7,  2015: First commit
// Jul 24, 2018: Fix layout
//////////////////////////////////////////////////////////////////////