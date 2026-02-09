// ----------------------
// Index wrap helpers (cap >= 2)
// ----------------------

procedure wrap_inc(int cap, int idx)
  // idx := (idx + 1) mod cap
  // entry: idx = cap-1 ?
  if idx = cap - 1 then
    idx -= cap - 1     // -> 0
  else
    idx += 1
  fi idx = 0

procedure wrap_dec(int cap, int idx)
  // idx := (idx - 1) mod cap
  // entry: idx = 0 ?
  if idx = 0 then
    idx += cap - 1     // -> cap-1
  else
    idx -= 1
  fi idx = cap - 1


// ----------------------
// Stack (array + top)
// ----------------------

procedure stack_push(int S[], int t, int x)
  // Pre: S[t] = 0
  S[t] <=> x
  t += 1

procedure stack_pop(int S[], int t, int x)
  // Pre: x = 0
  t -= 1
  S[t] <=> x


// ----------------------
// Queue (circular buffer, array + head/tail/sz)
// ----------------------

procedure queue_enqueue(int cap, int Q[], int tail, int sz, int x)
  // Pre: Q[tail] = 0, 0 <= sz < cap
  Q[tail] <=> x
  call wrap_inc(cap, tail)
  sz += 1

procedure queue_dequeue(int cap, int Q[], int head, int sz, int x)
  // Pre: x = 0, 0 < sz <= cap
  Q[head] <=> x
  call wrap_inc(cap, head)
  sz -= 1


// ----------------------
// Deque (circular buffer, array + head/sz)
// head points to the front element (valid when sz>0)
// tail is derived as (head + sz) mod cap, maintained explicitly as tail.
// ----------------------

procedure deque_push_front(int cap, int D[], int head, int tail, int sz, int x)
  // Pre: sz < cap, and the slot we write becomes free after head moves
  call wrap_dec(cap, head)
  // after moving head backward, that slot must be 0
  D[head] <=> x
  sz += 1

procedure deque_pop_front(int cap, int D[], int head, int tail, int sz, int x)
  // Pre: sz > 0, x = 0
  D[head] <=> x
  call wrap_inc(cap, head)
  sz -= 1

procedure deque_push_back(int cap, int D[], int head, int tail, int sz, int x)
  // Pre: sz < cap, D[tail]=0
  D[tail] <=> x
  call wrap_inc(cap, tail)
  sz += 1

procedure deque_pop_back(int cap, int D[], int head, int tail, int sz, int x)
  // Pre: sz > 0, x = 0
  call wrap_dec(cap, tail)
  D[tail] <=> x
  sz -= 1


// ----------------------
// Test helpers
// ----------------------

procedure assert_eq_int(int x, int y)
  assert(x = y)

procedure assert_all_zero(int n, int A[])
  iterate int i = 0 to n-1
    assert(A[i] = 0)
  end

procedure assert_eq_array(int n, int X[], int Y[])
  iterate int i = 0 to n-1
    assert(X[i] = Y[i])
  end


// ----------------------
// Tests
// ----------------------

procedure main()
  // ---------- Stack test ----------
  int S[8]
  int t = 0
  int x = 7
  int y = 0

  int cap = 5
  int Q[5]
  int head = 0
  int tail = 0
  int sz = 0
  int a = 11
  int b = 22
  int out1 = 0
  int out2 = 0

  int D[5]
  int dh = 0
  int dt = 0
  int ds = 0
  int p = 3
  int q = 4
  int r = 5
  int o1 = 0
  int o2 = 0
  int o3 = 0

  call stack_push(S, t, x)
  call assert_eq_int(x, 0)
  call assert_eq_int(t, 1)

  call stack_pop(S, t, y)
  call assert_eq_int(y, 7)
  call assert_eq_int(t, 0)

  // Uncall should restore everything (including y back to 0, and x back to 7)
  uncall stack_pop(S, t, y)
  uncall stack_push(S, t, x)

  call assert_eq_int(t, 0)
  call assert_eq_int(x, 7)
  call assert_eq_int(y, 0)
  call assert_all_zero(8, S)

  // ---------- Queue test ----------

  call queue_enqueue(cap, Q, tail, sz, a)
  call queue_enqueue(cap, Q, tail, sz, b)
  call assert_eq_int(a, 0)
  call assert_eq_int(b, 0)
  call assert_eq_int(sz, 2)

  call queue_dequeue(cap, Q, head, sz, out1)
  call queue_dequeue(cap, Q, head, sz, out2)
  call assert_eq_int(out1, 11)
  call assert_eq_int(out2, 22)
  call assert_eq_int(sz, 0)

  // Uncall (reverse the whole sequence)
  uncall queue_dequeue(cap, Q, head, sz, out2)
  uncall queue_dequeue(cap, Q, head, sz, out1)
  uncall queue_enqueue(cap, Q, tail, sz, b)
  uncall queue_enqueue(cap, Q, tail, sz, a)

  call assert_eq_int(head, 0)
  call assert_eq_int(tail, 0)
  call assert_eq_int(sz, 0)
  call assert_eq_int(a, 11)
  call assert_eq_int(b, 22)
  call assert_eq_int(out1, 0)
  call assert_eq_int(out2, 0)
  call assert_all_zero(5, Q)

  // ---------- Deque test ----------
  // push_front(p), push_back(q), push_front(r)  => front order: r, p, q
  call deque_push_front(cap, D, dh, dt, ds, p)
  call deque_push_back (cap, D, dh, dt, ds, q)
  call deque_push_front(cap, D, dh, dt, ds, r)
  call assert_eq_int(p, 0)
  call assert_eq_int(q, 0)
  call assert_eq_int(r, 0)
  call assert_eq_int(ds, 3)

  call deque_pop_front(cap, D, dh, dt, ds, o1)  // r
  call deque_pop_front(cap, D, dh, dt, ds, o2)  // p
  call deque_pop_front(cap, D, dh, dt, ds, o3)  // q
  call assert_eq_int(o1, 5)
  call assert_eq_int(o2, 3)
  call assert_eq_int(o3, 4)
  call assert_eq_int(ds, 0)

  // reverse
  uncall deque_pop_front(cap, D, dh, dt, ds, o3)
  uncall deque_pop_front(cap, D, dh, dt, ds, o2)
  uncall deque_pop_front(cap, D, dh, dt, ds, o1)
  uncall deque_push_front(cap, D, dh, dt, ds, r)
  uncall deque_push_back (cap, D, dh, dt, ds, q)
  uncall deque_push_front(cap, D, dh, dt, ds, p)

  call assert_eq_int(dh, 0)
  call assert_eq_int(dt, 0)
  call assert_eq_int(ds, 0)
  call assert_eq_int(p, 3)
  call assert_eq_int(q, 4)
  call assert_eq_int(r, 5)
  call assert_eq_int(o1, 0)
  call assert_eq_int(o2, 0)
  call assert_eq_int(o3, 0)
  call assert_all_zero(5, D)