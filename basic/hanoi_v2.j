/////////////////////////////////////////////////////////
// Hanoi
// (c) Tetsuo Yokoyama, 2026/02/09
// https://tetsuo.jp/jana-playground-mult-eq/#797f08f7

procedure initialize(int n, stack p1, stack p2, stack p3)
    iterate int i = n by -1 to 1
        local int m = i
        push(m, p1)
        delocal int m = 0
    end

procedure printPiles(stack p1, stack p2, stack p3)
    show(p1)
    show(p2)
    show(p3)

procedure moveOne(stack ff, stack tt)
    local int x
    pop(x,ff)
    push(x,tt)
    delocal int x

procedure hanoi(int n, stack ff, stack tt, stack work)
    if n != 0 then
        call hanoi(n-1,ff,work,tt)
        call moveOne(ff,tt)
        call hanoi(n-1,work,tt,ff)
    fi n != 0

procedure main()
    stack p0
    stack p1
    stack p2
    int n = 5

    call initialize(n,p0,p1,p2)
    call printPiles(p0,p1,p2)
    call hanoi(n, p0, p2, p1)
