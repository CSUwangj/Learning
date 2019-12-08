# 1.1

```answer
10
12
8
3
6
null
null
19
#f
4
16
6
16
```

# 1.2

```scheme
(/ (+ 5 4
      (- 2
         (- 3
            (+ 6
               (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))
```

# 1.3

```scheme
(define (max-two-of-three a b c)
  (cond ((and (<= a b) (<= a c)) (+ b c))
        ((and (<= b a) (<= b c)) (+ a c))
        (else (+ a b))))
```

# 1.4

$a+|b|$

# 1.5

application-order:

```scheme
(test 0 (p))

(test 0 (p))

(test 0 (p))
loop to the end of world to expand (p) 
```

normal-order:

```scheme
(test 0 (p))

(if (= 0 0)
    0
    (p))

(if #t 0 (p))

0
```

# 1.6

run out of memory.

Because compiler use application-order evaluation, and new-if is a function, so both parameters will be evaluated, which lead to infinite recursion.

code to show this difference:

```scheme
=> (if #t (display "good") (display "bad"))
good
=> (new-if #t (display "good") (display "bad"))
badgood
```

# 1.7

```scheme
(sqrt 0.0000001)
; 0.03125106561775382
(sqrt 1000000000000000000000000000000000000)
; stucked
```

It's obvious why tiny number get wrong square root. For large number, as we all know float point number have a accuracy limit, in practice, we always use IEEE Standard 754. When difference is so large that standard dones't support us to express such small change on large number, which lead to unchanged large number.

```scheme
(define (good-enough? guess x)
  (< (abs (/ (- (square guess) x) x)) 0.001))
```

# 1.8

```scheme
(define (improve guess x)
  (/ (+ (/ x 
           (* guess guess)) 
        (* 2 guess))
     3))

(define (good-enough? guess x)
  (< (abs (/ (- (rubic guess) x) x)) 0.001))

(define (rubic x)
  (* x x x))

(define (rbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (rbrt-iter (improve guess x)
                 x)))
(define (rbrt x)
  (rbrt-iter 1.0 x))
```

# 1.9

first one is recursive:

```scheme
(+ 4 5)

(inc (+ (dec 4) 5))

(inc (+ 3 5))

(inc (inc (+ (dec 3) 5)))

(inc (inc (+ 2 5)))

(inc (inc (inc (+ (dec 2) 5))))

(inc (inc (inc (+ 1 5))))

(inc (inc (inc (inc (+ (dec 1) 5 )))))

(inc (inc (inc (inc (+ 0 5 )))))

(inc (inc (inc (inc 5))))

(inc (inc (inc 6)))

(inc (inc 7))

(inc 8)

9
```

second one is iterative:

```scheme
(+ 4 5)

(+ (dec 4) (inc 5))

(+ 3 6)

(+ (dec 3) (inc 6))

(+ 2 7)

(+ (dec 2) (inc 7))

(+ 1 8)

(+ (dec 1) (inc 8))

(+ 0 9)

9
```

# 1.10

```scheme
(A 1 10)
; 1024
(A 2 4)
; 65536
(A 3 3)
; 65536
```

(f n) computes $2n$.

(g n) computes $\left\{\begin{matrix} 0, n=0\\2^n,n>0\\NaN,n<0\end{matrix}\right.$.

(h n) computes$\left\{\begin{matrix} 0, n=0\\2\uparrow n,n>0\\NaN,n<0\end{matrix}\right.$.

# 1.11

recursive process:

```scheme
#lang racket

(define (f n)
  (cond ((< n 3) n)
         (else (+ (f (- n 1))
                  (* 2 (f (- n 2)))
                  (* 3 (f (- n 3)))))))
```

iterative process:

```scheme
(define (f-it n)
  (if (>= n 0)
      (f-iter 2 1 0 n)
      n))

(define (f-iter n_2 n_1 n count)
  (if
   (= count 0)
      n
       (f-iter (+ n_2
                  (* 2 n_1)
                  (* 3 n))
               n_2
               n_1
               (- count 1))))
```

# 1.12

```scheme
(define (pascal_triangle row col)
  (cond ((or (= col 1) (= row col)) 1)
        (else (+ (pascal_triangle (- row 1)
                                  (- col 1))
                 (pascal_triangle (- row 1)
                                  col)))))
```

# 1.13

**Proof.** Let $P(n)$ be the statement $f(n)=\frac{\phi ^n-\psi ^n}{\sqrt{5}}$ where $f(n)=\left\{\begin{matrix}0,n=0\\1,n=1\\f(n-1)+f(n-1),n>1\\\end{matrix}\right. , \phi = \frac{1+\sqrt{5}}{2}, \psi = \frac{1-\sqrt{5}}{2}$. We give a proof by induction on $n$.

*Base case:* $P(0)$、$P(1)$ is easily seen to be true: 
$$0=\frac{\phi ^0-\psi ^0}{\sqrt{5}}$$
$$1=\frac{\phi ^1-\psi ^1}{\sqrt{5}}$$

*Inductive step:* Show that for any $k \geq 0$ that if $P(k)$ and $P(k+1)$ holds, then $P(k+2)$ also holds. This can be done as follows.

Assume the induction hypothsis that $P(k)$ and $P(k+1)$ is true (for some arbitrary value of $k \geq 0$). It must then be shown that $P(k+2)$ is true, that is:
$$f(k+2)=\frac{\phi ^{k+2}-\psi ^{k+2}}{\sqrt{5}}$$
Using the computation rule and induction hypothesis, the left-hand side can be equated to:
$$f(k)+f(k+1)$$
$$\frac{\phi ^{k}-\psi ^{k}}{\sqrt{5}}+\frac{\phi ^{k+1}-\psi ^{k+1}}{\sqrt{5}}$$
Algebraically, we have that:
$$\begin{aligned}
  \frac{\phi ^{k}-\psi ^{k}}{\sqrt{5}}+\frac{\phi ^{k+1}-\psi ^{k+1}}{\sqrt{5}} &=\frac{\frac{3+\sqrt{5}}{2}\phi^k + \frac{3-\sqrt{5}}{2}\psi ^k}{\sqrt{5}}\\&=\frac{\phi ^{k+2}-\psi ^{k+2}}{\sqrt{5}}
\end{aligned}$$
which shows that $P(k+2)$ indeed holds.

---

And it's obvious that $|1-\sqrt{5}|<2$, so $\lim_{x\to+\infin}\psi ^x=0.$ Which means $Fib(n)$ is the closest integer to $\frac{\phi ^n}{\sqrt{5}}$.

# 1.14

This tree image is so big that it make me feel fucked...

I'm confident that order of growth of the number of steps is $\Theta(k^n)$ where $k>1$, space is $\Theta(n)$.

# 1.15

I use racket and code below to check how many times *p* need to be evaluate before "bottom down" to piece.

```scheme
(define (count number c)
  (if (< (abs number) 0.1)
      c
      (count (/ number 3.0)
             (+ c 1))))
(count 12.15 0)
; 5
```

And each time we evaluated *p*, it's evaluated and split into two *p*, so in all we applied *p* $1+2+4+8+16=31$ times.

---

Order of growth of space growth with "bottom down" process, and each time devide parameter by three, so it's $\Theta(\log^n)$(do not care about constant).

On the other hand, number of steps grow quicker, because every time applied procedure *p*, *p* will be called two more times. So the answer is $2^{\log_3^n}=2^{\log_2^3*\log_3^n\div\log_2^3}=kn$, which is $\Theta(n)$.

# 1.16

```scheme
(define (fast-expt b n)
  (fast-expt-iter b 1 n))

(define (even? n)
  (= (remainder n 2) 0))

(define (square a)
  (* a a))

(define (fast-expt-iter b a n)
  (if (= n 0)
      a
      (if (even? n)
          (fast-expt-iter (square b)
                          a
                          (/ n 2))
          (fast-expt-iter b
                          (* a b)
                          (- n 1)))))
```

# 1.17

```scheme
(define (even? n)
  (= (remainder n 2) 0))

(define (double a)
  (+ a a))

(define (* a b)
  (cond ((= b 0) 0)
        ((even? b) (double (* a (/ b 2))))
        (else (+ a (* a (- b 1))))))
```

# 1.18

```scheme
(define (* a b)
  (*-iter a 0 b))

(define (*-iter a n b)
  (if (= b 0)
      n
      (if (even? b)
          (*-iter (double a)
                  n
                  (/ b 2))
          (*-iter a
                  (+ n a)
                  (- b 1)))))
```

# 1.19

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p)
                      (* q q))
                   (+ (* 2 p q)
                      (* q q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
```

All we need to do is to replace $a$ with $bq=aq+ap$, replace $b$ with $bp+aq$, then we have:
$$\begin{aligned}
  p\prime&=p^2+q^2\\q\prime&=2pq+q^2
\end{aligned}$$

# 1.20

normal-order:

```scheme
(gcd 206 40)

(if (= 40 0)
    204
    (gcd 40 (remainder 206 40)))

(if #f
    204
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

(if (= (remainder 206 40) 0)
    40
    (gcd 6 (remainder 40 6)))

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6)))

(if #f
    40
    (gcd 6 (remainder 40 6)))

(gcd 6 (remainder 40 6))

(if (= (remainder 40 6) 0)
    6
    (gcd 4 (remainder 6 4)))

(if (= 4 0)
    6
    (gcd 4 (remainder 6 4)))

(if #f
    6
    (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))

(if (= (remainder 6 4) 0)
    4
    (gcd 2 (remainder 4 2)))

(if (= 2 0)
    4
    (gcd 2 (remainder 4 2)))

(if #f
    4
    (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))

(if (= (remainder 4 2) 0)
    2
    (gcd 0 (remainder 2 0)))

(if (= 0 0)
    2
    (gcd 0 (remainder 2 0)))

(if #t
    2
    (gcd 0 (remainder 2 0)))

2
```

application-order:

```scheme
(gcd 206 40)

(if (= 40 0)
    204
    (gcd 40 (remainder 206 40)))

(if #f
    204
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

(gcd 40 6)

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6)))

(if #f
    40
    (gcd 6 (remainder 40 6)))

(gcd 6 (remainder 40 6))

(gcd 6 4)

(if (= 4 0)
    6
    (gcd 4 (remainder 6 4)))

(if #f
    6
    (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))

(gcd 4 2)

(if (= 2 0)
    4
    (gcd 2 (remainder 4 2)))

(if #f
    4
    (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))

(gcd 2 0)

(if (= 0 0)
    2
    (gcd 0 (remainder 2 0)))

(if #t
    2
    (gcd 0 (remainder 2 0)))

2
```

Feel so stupid... I should've write a program to generate it rather than hand made...

# 1.21

199 1999 7

# 1.22

1009 1013 1019

10007 10009 10037

100003 100019 100043 

1000003 1000033 1000037

Because (runtime) has less accuracy than need, I can't observe any difference on these process.

# 1.23

Because (runtime) has less accuracy than need, I can't observe any difference on these process.

# 1.24

Because (runtime) has less accuracy than need, I can't observe any difference on these process.

# 1.25

Yes and no. 

If we use big integer as default, this algorithm will give us correct answer, because modular equivalence is compatibility with translation/scaling/addition/subtraction/multiplication/exponentiation.

But we usually not use big integer as default, and even if default number is big integer(like in Python), arithmetic on big number is not a good idea.

# 1.26

Because interpreter use application-order to evaluation parameters, so every multiplication will evaluate both parameters to check what is it, and so 
```scheme
(* (expmod base (/ exp 2) m)
   (expmod base (/ exp 2) m))
```
evaluate `(expmod base (/ exp 2) m)` twice, which cause this algorithm doesn't fast any more.

# 1.27

```scheme
(define (test a n)
    (= (expmod a n n) a))

(define (fool-fermat n)
  (cond ((prime? n) #f)
        ((not (fermat-tell-yes n)) #f)
        (else #t)))

(define (fermat-tell-yes n)
  (iter 1 n))

(define (iter a n)
  (if (< a n)
      (if (test a n)
          (iter (+ a 1) n)
          #f)
      #t))
```

```scheme
(fool-fermat 561) 
; #t
(fool-fermat 1105)
; #t
(fool-fermat 1729)
; #t
(fool-fermat 2465)
; #t
(fool-fermat 2821)
; #t
(fool-fermat 6601)
; #t
```

# 1.28

```scheme
(miller-rabin-test 561) 
; #f
(miller-rabin-test 1105)
; #t
(miller-rabin-test 1729)
; #t
(miller-rabin-test 2465)
; #f
(miller-rabin-test 2821)
; #t
(miller-rabin-test 6601)
; #t
```

# 1.29

```scheme
#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (cube x)
  (* x x x))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (inc a)
    (+ 1 a))
  (define (term k)
    (define yk
      (f (+ a (* k h))))
    (cond ((or (= 0 k) (= n k)) yk)
          ((even? k) (* 2 yk))
          (else (* 4 yk))))
  (/ (* h (sum term 0 inc n)) 3.0))

(integral cube 0 1 0.01) 
; 0.24998750000000042
(simpson cube 0 1 100)   
; 0.25
(integral cube 0 1 0.001)
; 0.249999875000001
(simpson cube 0 1 1000)  
; 0.25
```

# 1.30

```scheme
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))
```

# 1.31

```scheme
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial-iter n)
  (define (term x)
    (cond ((> x 0) x)
          (else 1)))
  (define (inc a)
    (+ 1 a))
  (product-iter term 0 inc n))

(define (pi n)
  (define (term n)
    (/ (+ (* (/ (- n
                   (remainder n 2))
                2)
             2)
          2)
       (+ (* (/ (+ n
                    (remainder n 2))
                 2)
              2)
           1)))
  (define (inc a)
    (+ 1 a))
  (* (product term 1 inc n) 4.0))
```

# 1.32

```scheme
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate-iter * 1 term a next b))
```

# 1.33

```scheme
(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filter (term a))
                    (term a)
                    null-value)
                (filtered-accumulate filter combiner null-value term (next a) next b))))

(define (sum-of-prime a b)
  (filtered-accumulate prime + 0 (lambda (x) x) a next b))

(define (product-of-relative-prime n)
  (define (relative-prime? a)
    (= (gcd a n)
       1))
  (filtered-accumulate relative-prime? * 1 (lambda (x) x) 1 next n))
```

# 1.34

Interpreter said:

```scheme
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments...:
```

Because `(f f)` become `(f 2)` which get `(2 2)`, if we ask interpreter deal with `(2 2)` or `(f 2)`, we will get same message.

# 1.34

$$ x=1+\frac{1}{x}$$
$$x^2-x-1=0$$
so
$$x=\frac{1\plusmn\sqrt{5}}{2}$$

```scheme
(define (golden x)
  (+ 1 (/ 1 x)))

(fixed-point golden 1.0)
; 1.6180327868852458
```

# 1.36

```scheme
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (display guess) ; here
    (newline)       ;
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
; 10
; 2.9999999999999996
; 6.2877098228681545
; 3.7570797902002955
; 5.218748919675316
; 4.1807977460633134
; 4.828902657081293
; 4.386936895811029
; 4.671722808746095
; 4.481109436117821
; 4.605567315585735
; 4.522955348093164
; 4.577201597629606
; 4.541325786357399
; 4.564940905198754
; 4.549347961475409
; 4.5596228442307565
; 4.552843114094703
; 4.55731263660315
; 4.554364381825887
; 4.556308401465587
; 4.555026226620339
; 4.55587174038325
; 4.555314115211184
; 4.555681847896976
; 4.555439330395129
; 4.555599264136406
; 4.555493789937456
; 4.555563347820309
; 4.555517475527901
; 4.555547727376273
; 4.555527776815261
; 4.555540933824255
; 4.555532257016376
```

# 1.37

```scheme
(define (cout-frac n d k)
  (define (iter a)
    (if (> a k)
        0
        (/ (n a)
           (+ (d a) (iter (inc a))))))
  (iter 1))

(define (cout-frac-iter n d k)
  (define (iter a result)
    (if (< a 1)
        result
        (iter (- a 1)
              (/ (n a)
                 (+ result (d k))))))
  (iter k 0))

(cout-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)
; 0.6180555555555556
(cout-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)
; 0.6180257510729613           
```

# 1.38

```scheme
(+ 2 (cout-frac-iter (lambda (i) 1.0)
           (lambda (i)
             (if (= (remainder i 3) 1)
                 (* 2 (/ (+ i 2) 3))
                 1))
           102))
```

Because of lack of accuracy, answer is always wrong especially when $k\equiv1\mod 3$.

# 1.39

```scheme
(define (tan-cf x k)
  (define (cout-frac n d k)
    (define (iter a)
      (if (> a k)
          0
          (/ (n a)
             (- (d a) (iter (inc a))))))
    (iter 1))
  (cout-frac (lambda (i) (exp x i))
                  (lambda (i) (- (* i 2) 1))
                  k))
```

# 1.40

```scheme
(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (sqare x))
       (* b x)
       c)))
```

# 1.41

```scheme
(define (double f)
  (lambda (x)
    (f (f x))))

(((double (double double)) inc) 5)
; 21
```

# 1.42

```scheme
(define (compose f g)
  (lambda (x)
    (f (g x))))
```

# 1.43

```scheme
(define (repeat f n)
  (define (iter x result)
    (if (> x n)
        result
        (iter (+ x 1) (compose f result))))
  (iter 1 (lambda (x) x)))
```

# 1.44

```scheme
(define (smooth dx)
  (lambda (f)
    (lambda (x)
      (/ (+ (f (- x dx))
            (f (x))
            (f (+ x dx)))
         3))))

(define smooth-inst (smooth 0.00001))

(define (n-fold-smooth n) (repeat smooth-inst n))
```

# 1.45

```scheme
(define (nth-root-of x n)
  (fixed-point-of-transform
    (lambda (y) (/ x (expt y (- n 1))))
    (repeated average-damp (damp-number n))
    1.0))
```

# 1.46

```scheme
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve)
         (improve guess)))))

(define (sqrt x)
  (define (good-enough? guess)
    (let ((tolerance 0.001))
      (< (abs (- square guess) x)) tolerance))
  (define (average x y)
    (/ (+ x y) 2))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1.0))

(define (fixed-point f guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (let ((good-enough? (lambda (x) (close-enough? x (f x))))
        (improve f))
    ((iterative-improve good-enough? improve) guess)))
```