// reversible_linked_list.j
// Doubly linked list (index-based) for Jana-JanusInterp
// https://tetsuo.jp/jana-playground-mult-eq/#47f3ec70

// ----------------------
// Basic initialization
// ----------------------

procedure list_init_empty(int next[], int prev[])
  // Set sentinel links to 0 (assumes they start 0; keeps them 0)
  // (No self-referential compound assignments used.)
  skip

procedure node_init_free(int x, int next[], int prev[])
  // Ensure next[x]=0, prev[x]=0
  // (Assumes arrays start at 0; kept for symmetry.)
  skip


// ----------------------
// Core operations
// ----------------------

procedure list_insert_after(int p, int x, int next[], int prev[], int q, int len)
  // Insert free node x right after node p (p may be 0 for inserting at front).
  //
  // Pre:
  // - next[x]=0, prev[x]=0
  // - q=0
  // Post:
  // - x is linked between p and oldNext
  // - q restored to 0
  // - len += 1

  // q := oldNext = next[p], and clear next[p] to 0
  q <=> next[p]            // q=oldNext, next[p]=0

  // next[p] := x
  next[p] += x

  // prev[x] := p
  prev[x] += p

  // next[x] := oldNext, and clear q back to 0
  next[x] <=> q            // next[x]=oldNext, q=0

  // Update prev[oldNext] := x, but first extract its old value into q (q=0 on entry)
  // In a well-formed list, old prev[oldNext] should be p (including oldNext=0 uses prev[0]).
  q <=> prev[next[x]]      // q=oldPrev, prev[oldNext]=0
  prev[next[x]] += x       // prev[oldNext]=x

  // Clean q using the known expected oldPrev = p
  q -= p                   // q=0

  len += 1


procedure list_remove(int x, int next[], int prev[], int p, int q, int t, int len)
  // Remove node x (x != 0) from the list, making it free.
  //
  // Pre:
  // - p=0, q=0, t=0
  // Post:
  // - next[x]=0, prev[x]=0
  // - p=q=t=0
  // - len -= 1

  // p := prev[x], clear prev[x]
  p <=> prev[x]            // p=prevx, prev[x]=0

  // q := next[x], clear next[x]
  q <=> next[x]            // q=nextx, next[x]=0

  // next[p] should be x; set next[p] := q without self-reference
  t <=> next[p]            // t=old (should be x), next[p]=0
  next[p] += q             // next[p]=q
  t -= x                   // clean t back to 0

  // prev[q] should be x; set prev[q] := p
  t <=> prev[q]            // t=old (should be x), prev[q]=0
  prev[q] += p             // prev[q]=p
  t -= x                   // clean t back to 0

  // Clean p and q using the now-updated links:
  // After updates, prev[q] = p and next[p] = q
  p -= prev[q]             // p=0 (RHS does not mention p syntactically)
  q -= next[p]             // q=0

  len -= 1


// ----------------------
// Assertions
// ----------------------

procedure assert_eq_int(int a, int b)
  assert(a = b)

procedure assert_links(int next[], int prev[],
                       int n0, int p0,
                       int n1, int p1,
                       int n2, int p2,
                       int n3, int p3)
  // Check a few sentinel/node links (for tests)
  assert(next[0] = n0)
  assert(prev[0] = p0)
  assert(next[1] = n1)
  assert(prev[1] = p1)
  assert(next[2] = n2)
  assert(prev[2] = p2)
  assert(next[3] = n3)
  assert(prev[3] = p3)


// ----------------------
// Tests
// ----------------------

procedure main()
  // Declarations (must all be here)
  int next[6]
  int prev[6]

  int len = 0

  // temps (must be 0 when passed)
  int p = 0
  int q = 0
  int t = 0

  // --- init empty list and free nodes (arrays default 0) ---
  call list_init_empty(next, prev)
  call node_init_free(1, next, prev)
  call node_init_free(2, next, prev)
  call node_init_free(3, next, prev)

  // Build list: insert 2 after 0, then 1 after 2, then 3 after 1
  // Expected order: 0 -> 2 -> 1 -> 3 -> 0
  call list_insert_after(0, 2, next, prev, q, len)
  call list_insert_after(2, 1, next, prev, q, len)
  call list_insert_after(1, 3, next, prev, q, len)

  call assert_eq_int(len, 3)
  call assert_eq_int(p, 0)
  call assert_eq_int(q, 0)
  call assert_eq_int(t, 0)

  // Check links for nodes 0..3
  // next[0]=2, prev[0]=3
  // next[2]=1, prev[2]=0
  // next[1]=3, prev[1]=2
  // next[3]=0, prev[3]=1
  call assert_links(next, prev,
                    2, 3,
                    3, 2,
                    1, 0,
                    0, 1)

  // Remove node 1; list becomes 0 -> 2 -> 3 -> 0
  call list_remove(1, next, prev, p, q, t, len)

  call assert_eq_int(len, 2)
  call assert_eq_int(next[1], 0)
  call assert_eq_int(prev[1], 0)

  // Check updated links:
  // next[0]=2, prev[0]=3
  // next[2]=3, prev[2]=0
  // next[3]=0, prev[3]=2
  call assert_links(next, prev,
                    2, 3,
                    0, 0,   // node 1 is free
                    3, 0,
                    0, 2)

//   // Reversibility: undo remove and inserts
//   uncall list_remove(1, next, prev, p, q, t, len)
//   uncall list_insert_after(1, 3, next, prev, q, len)
//   uncall list_insert_after(2, 1, next, prev, q, len)
//   uncall list_insert_after(0, 2, next, prev, q, len)
// 
//   call assert_eq_int(len, 0)
//   call assert_eq_int(p, 0)
//   call assert_eq_int(q, 0)
//   call assert_eq_int(t, 0)
// 
//   // Empty list again
//   call assert_eq_int(next[0], 0)
//   call assert_eq_int(prev[0], 0)