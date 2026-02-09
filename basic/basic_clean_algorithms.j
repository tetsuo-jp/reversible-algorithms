//https://tetsuo.jp/jana-playground-mult-eq/#36c5cc91
procedure copy_array(int n, int A[], int B[])
  iterate int i = 0 to n-1
    B[i] += A[i]
  end

procedure sum_array(int n, int A[], int S)
  iterate int i = 0 to n-1
    S += A[i]
  end

procedure diff_array(int n, int A[], int D[])
  // D[0] = A[0]
  D[0] += A[0]
  // D[i] = A[i] - A[i-1] for i>=1
  iterate int i = 1 to n-1
    D[i] += A[i]
    D[i] -= A[i-1]
  end

procedure prefixsum_clean(int n, int A[], int B[])
  // Pre : B[0]=0, B[1..n]=0
  // Post: B[k] = sum_{j=0..k-1} A[j] for k=1..n
  iterate int i = 0 to n-1
    B[i+1] += B[i]
    B[i+1] += A[i]
  end

procedure reverse_array(int n, int A[])
  iterate int i = 0 to (n/2)-1
    A[i] <=> A[n-1-i]
  end

procedure scale_array(int n, int k, int A[], int B[])
  iterate int i = 0 to n-1
    B[i] += k * A[i]
  end

procedure sum_even(int n, int A[], int S)
  iterate int i = 0 to n-1
    if A[i] % 2 = 0 then
      S += A[i]
    fi A[i] % 2 = 0
  end

procedure affine_array(int n, int a, int b, int A[], int B[])
  iterate int i = 0 to n-1
    B[i] += a * A[i] + b
  end


// ----------------------
// Test helpers
// ----------------------

procedure assert_eq_array(int n, int X[], int Y[])
  iterate int i = 0 to n-1
    assert(X[i] = Y[i])
  end

procedure assert_eq_int(int x, int y)
  assert(x = y)

procedure assert_all_zero(int n, int X[])
  iterate int i = 0 to n-1
    assert(X[i] = 0)
  end


// ----------------------
// Test main
// ----------------------

procedure main()
  // Base input
  int n = 5
  int A[] = {3,1,4,1,5}
  int C[5]
  int Cexp[] = {3,1,4,1,5}
  int S = 0
  int D[5]
  int Dexp[] = {3,-2,3,-3,4}   // A: 3,1,4,1,5
  int B[6]                    // B[0..n]
  int Bexp[] = {0,3,4,8,9,14}
  int R[] = {3,1,4,1,5}
  int Rexp[] = {5,1,4,1,3}
  int k = 3
  int SC[5]
  int SCexp[] = {9,3,12,3,15}
  int Ad[] = {3,1,4,2,5}   // positive + pairwise distinct
  int M = 0
  int Se = 0
  int a = 2
  int b = 1
  int AF[5]
  int AFexp[] = {7,3,9,3,11}       // 2*A + 1

  // 1) copy_array
  call copy_array(n, A, C)
  call assert_eq_array(n, C, Cexp)
  uncall copy_array(n, A, C)
  call assert_all_zero(n, C)

  // 2) sum_array
  call sum_array(n, A, S)
  call assert_eq_int(S, 14)
  uncall sum_array(n, A, S)
  call assert_eq_int(S, 0)

  // 3) diff_array
  call diff_array(n, A, D)
  call assert_eq_array(n, D, Dexp)
  uncall diff_array(n, A, D)
  call assert_all_zero(n, D)

  // 4) prefixsum_clean
  call prefixsum_clean(n, A, B)
  call assert_eq_array(n+1, B, Bexp)
  uncall prefixsum_clean(n, A, B)
  call assert_all_zero(n+1, B)

  // 5) reverse_array (in-place)
  call reverse_array(n, R)
  call assert_eq_array(n, R, Rexp)
  uncall reverse_array(n, R)
  call assert_eq_array(n, R, A)   // restored to original A

  // 6) scale_array
  call scale_array(n, k, A, SC)
  call assert_eq_array(n, SC, SCexp)
  uncall scale_array(n, k, A, SC)
  call assert_all_zero(n, SC)

  // 7) sum_even
  call sum_even(n, A, Se)          // A has only one even element: 4
  call assert_eq_int(Se, 4)
  uncall sum_even(n, A, Se)
  call assert_eq_int(Se, 0)

  // 8) affine_array
  call affine_array(n, a, b, A, AF)
  call assert_eq_array(n, AF, AFexp)
  uncall affine_array(n, a, b, A, AF)
  call assert_all_zero(n, AF)