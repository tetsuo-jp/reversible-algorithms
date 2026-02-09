// Clean reversible prefix sum
// Pre : i = 0, B[0] = 0, B[1..n] = 0
// Post: i = 0, A unchanged, B[k] = sum_{j=1..k} A[j]

procedure prefixsum_clean(int n, int A[], int B[])
  // forward phase: build prefix sums into B
  iterate int i = 0 to n-1
    B[i+1] += B[i]
    B[i+1] += A[i]
  end

procedure main()
  int n = 5
  int A[] = {3,1,4,1,5}
  int B[6]

  call prefixsum_clean(n, A, B)

  // now B[1..5] should be: {3, 4, 8, 9, 14}
  show(A, B, n)

  // invert: should restore B[1..n] to 0 and keep i = 0
  uncall prefixsum_clean(n, A, B)