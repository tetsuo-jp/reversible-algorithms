// FizzBuzz
// Tetsuo Yokoyama, 2024/06/21
// https://tetsuo.jp/janus-playground-180405/#d8226d5b

procedure main()
    iterate int i = 1 to 20
        if i % 3 = 0 && i % 5 = 0 then
            printf("%d:FizzBuzz", i)
        else
            if i % 3 = 0 then
                printf("%d:Fizz", i)
            else
                if i % 5 = 0 then
                    printf("%d:Buzz", i)
                else
                    printf("%d:", i)
                fi i % 5 = 0
            fi i % 3 = 0
        fi i % 3 = 0 && i % 5 = 0
    end

/*
Expected output:
1:
2:
3:Fizz
4:
5:Buzz
6:Fizz
7:
8:
9:Fizz
10:Buzz
11:
12:Fizz
13:
14:
15:FizzBuzz
16:
17:
18:Fizz
19:
20:Buzz
*/
