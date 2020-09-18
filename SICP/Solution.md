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

# 2.1

```scheme
(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (if (< (* n d) 0)
        (cons (* (- 1) (/ (abs n) g))
              (/ (abs d) g))
        (cons (/ (abs n) g) (/ (abs d) g)))))
```

# 2.2

```scheme
(define make-point cons)
(define x-point car)
(define y-point cdr)
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)
(define (midpoint-segment line)
  (make-point (average (x-point (start-segment line)) (x-point (end-segment line)))
              (average (y-point (start-segment line)) (y-point (end-segment line)))))
```

# 2.3

```scheme
; I assume that each segment of rectangle is rectangle is parallel to the coordinate axis.
(define (make-rec left-x right-x down-y up-y)
  (cons (cons left-x down-y)
        (cons right-x up-y)))
(define (height rec)
  (- (cdr (cdr rec))
     (cdr (car rec))))
(define (width rec)
  (- (car (cdr rec))
     (car (car rec))))
(define (area rec)
  (* (width rec)
     (height rec)))
(define (perimeter rec)
  (* (+ (height rec)
        (width rec))
     2))

  
(define (area rect)
  (* (width rect)
     (height rect)))

(define (perimeter rect)
  (* 2 (+ (width rect)
          (height rect))))
```

Another way(not use segment):

```scheme
(define make-rec cons)
(define height car)
(define width cdr)
```

# 2.4

```scheme
(define new-cons
  (lambda (x y)
    (lambda (f) (f x y))))
(define new-car
  (lambda (f)
    (f (lambda (x y) y))))
(define new-cdr
  (lambda (f)
    (f (lambda (x y) y))))
```

# 2.5

```scheme
(define (arith-cons a b)
  (* (expt 2 a)
     (expt 3 b)))
(define (arith-car p)
  (define (iter ans res)
    (if (= (remainder res 2) 0)
        (iter (+ ans 1) (/ res 2))
        ans))
  (iter 0 p))
(define (arith-cdr p)
  (define (iter ans res)
    (if (= (remainder res 3) 0)
        (iter (+ ans 1) (/ res 3))
        ans))
  (iter 0 p))
```

# 2.6

```scheme
(define one (add-1 zero))

(define two (add-1 (add-1 zero)))

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))
```

# 2.7

```scheme
(define upper-bound
  (lambda (x)
    (max (car x)
         (cdr x))))

(define lower-bound
  (lambda (x)
    (min (car x)
         (cdr x))))
```

# 2.8

```scheme
(define (sub-interval x y)
  (make-interval (- (lower-bound x)
                    (upper-bound y))
                 (- (upper-bound x)
                    (lower-bound y))))
```

# 2.9

Assume we have two intervals $x, y$, where $x$ is $y$ $(a,b)$ and $(c,d)$, width of those intervals is $\frac{b-a}{2}$ and $\frac{d-c}{2}$.

$x+y=(a+c, b+d)$. Its width is $\frac{b+d-a-c}{2}=\frac{b-a}{2}+\frac{d-c}{2}$.

$x-y=(a-d, b-c)$. Its width is $\frac{b+c-a-d}{2}=\frac{b-a}{2}-\frac{d-c}{2}$.

This pair of intervals let multiplication and devision fail: $(0, 2)$ and $(1,2)$.

# 2.10

```scheme
(define (div-interval x y)
  (if (> (* (upper-bound y)
            (lower-bound y))
         0)
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))
      0))
```

# 2.11

```scheme
(define (sign-pair lo up)
  (cond ((< lo up 0) -1)
        ((and (> up 0) (< lo 0) 0))
        (else 1)))

(define (mul-interval x y)
  (let ((xl (lower-bound x))
        (xu (upper-bound x))
        (yl (lower-bound y))
        (yu (upper-bound y)))
    (let ((xs (sign-pair xl xu))
          (ys (sign-pair yl yu)))
      (cond ((> xs 0)
             (cond ((> ys 0) (make-interval (* xl yl)
                                            (* xu yu)))
                   ((< ys 0) (make-interval (* xu yl)
                                            (* xl yu)))
                   ((= ys 0) (make-interval (* xu yl)
                                            (* xu yu)))))
            ((< xs 0)
             (cond ((> ys 0) (make-interval (* xl yu)
                                            (* xu yl)))
                   ((< ys 0) (make-interval (* xu yu)
                                            (* xl yl)))
                   ((= ys 0) (make-interval (* xl yu)
                                            (* xl yl)))))
            ((= xs 0)
             (cond ((> ys 0) (make-interval (* xl yu)
                                            (* xu yu))))
             (cond ((< ys 0) (make-interval (* yu xl)
                                            (* yl xl))))
             (cond ((= ys 0) (make-interval (min (* xu yl)
                                                 (* xl yu))
                                            (max (* xu yu)
                                                 (* xl yl))))))))))
```

# 2.12

```scheme
(define (make-center-percent c p)
  (make-interval (- c (* p c)) (+ c (* p c))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (/ (- (upper-bound i) (lower-bound i)) (+ (lower-bound i) (upper-bound i)) 0.01))
```

# 2.13

```scheme
; Suppose there are two intervals, namely a and b,
; where a = [ca - ta, ca + ta], b = [cb - tb, cb + tb]
; then a * b = [(ca - ta) * (cb - tb), (ca + ta) * (cb + tb)]
;            = [ca * cb - ca * tb - ta * cb + ta * tb,
;               ca * cb + ca * tb + ta * cb + ta * tb]
; note that in the above equation, ta * tb can be ignored.
; therefore we have
; a * b = (ca * cb) * [1 - tb / cb - ta / ca,
;                      1 + tb / cb + ta / ca]
;       = (ca * cb) * [1 - pb - pa, 1 + pb + pa]
;       = (ca * cb) * [1 - (pa + pb), 1 + (pa + pb)]

(define (mul-interval x y)
  (make-center-percent (* (center x) (center y))
                       (+ (percent x) (percent y))))
```

# 2.14

```scheme
(define (print-interval r)
  (display "[")
  (display (lower-bound r))
  (display ", ")
  (display (upper-bound r))
  (display "]")
  (newline))

(define (test)
  (let ((r1 (make-interval 1 2))
        (r2 (make-interval 2 3)))
    (display "par1: ")
    (print-interval (par1 r1 r2))
    (display "par2: ")
    (print-interval (par2 r1 r2))))

(test)
; par1: [0.4, 2.0]
; par2: [0.6666666666666666, 1.2000000000000002]
```

# 2.15

I'd say no. Because `par2` is better than `par1` in her system but not all system. In the mean while, we need to choose ways of computation depends on several factors, so it's hard to say which way is better in general. At least I don't know.

# 2.16

Because `par1` involve two computation on interval, but `par2` involve only one.

I can't yet.

# 2.17

```scheme
(define (last-pair list)
  (if (null? (cdr list))
      (car list)
      (last-pair (cdr list))))
```

# 2.18

```scheme
(define (reverse items)
  (define (iter current-item rest-items)
    (if (null? rest-items)
        current-item
        (iter (cons (car rest-items) current-item)
              (cdr rest-items))))
  (iter nil items))
```

# 2.19

```scheme
(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)
```

# 2.20

```scheme
(define (same-parity? x y)
  (= (remainder x 2) (remainder y 2)))

(define (same-parity first . rest)
  (define (iter rest current)
    (if (null? rest)
        current
        (iter (cdr rest)
              (if (same-parity? first (car rest))
                  (append current (list (car rest)))
                  current))))
  (cons first (iter rest nil)))
```s

# 2.21

```scheme
(define (square a)
  (* a a))

(define (square-list items)
  (if (null? items)
      nil
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list items)
  (map square items))
```

# 2.22

Because every cons can only append last one then it iterate to front.

Because list are `(cons l1 (cons l2 (cons l3 ...(cons nil)...)))`, not `(cons (cons (cons ...(cons l1 nil) l2) l3)...)`


# 2.23

```scheme
(define (for-each proc items)
  (cond ((null? items) #t)
      (else
       (proc (car items))
       (for-each proc (cdr items)))))
```

# 2.24

```scheme
;((1 2) 3 4)
```

Image again??? NO!

# 2.25

```scheme
(list 1 3 (list 5 7) 9)
(car (cdaddr (list 1 3 (list 5 7) 9)))
; (1 3 (5 7) 9)
; 7
(list (list 7))
(caar (list (list 7)))
; ((7))
; 7
(list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))
(cadadr (cadadr (cadadr (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))))
; (1 (2 (3 (4 (5 (6 7))))))
; 7
```

# 2.26

```scheme
; (1 2 3 4 5 6)
; ((1 2 3) 4 5 6)
; ((1 2 3) (4 5 6))
```

# 2.27

```scheme
(define (deep-reverse items)
  (define (iter current-items rest-items)
    (if (null? rest-items)
        current-items
        (iter (cons (if (list? (car rest-items))
                        (deep-reverse (car rest-items))
                        (car rest-items))
                    current-items)
              (cdr rest-items))))
  (iter nil items))
```

# 2.28

```scheme
(define (fringe items)
  (if (null? items)
      nil
      (append (if (list? (car items))
                  (fringe (car items))
                  (list (car items)))
              (if (list? (cdr items))
                  (fringe (cdr items))
                  (list (cdr items))))))
;;; a better one:
(define (fringe items)
  (cond ((null? items) nil)
        ((not (list? items)) (list items))
        (else (append (fringe (car items))
                      (fringe (cdr items))))))
```

# 2.29

```scheme
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

(define mobile? list?)
(define (total-weight mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (+ (if (mobile? left)
           (total-weight left)
           (branch-structure left))
       (if (mobile? right)
           (total-weight right)
           (branch-structure right)))))

(define (balanced mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (* (branch-length left) (total-weight left))
            (* (branch-length right) (total-weight right)))
         (if (mobile? left)
             (balanced left)
             #t)
         (if (mobile? right)
             (balanced right)
             #t))))

;;; All we need to do is change selector right-branch/branch-structure

(define right-branch cdr)
(define branch-structure cdr)
```

# 2.30

```scheme
(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))
```

# 2.31

```scheme
(define (tree-map f tree)
  (cond ((null? tree) nil)
        ((not (list? tree)) (f tree))
        (else (cons (tree-map f (car tree))
                    (tree-map f (cdr tree))))))
```

# 2.32

```scheme
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (x)
                       (cons (car s) x))
                     rest)))))
```   

Simple DP. 

If $s_1,s_2,...,s_n$ is subsets of $S$, $x$ is an element which is not in $S$. Then, the subsets of $S\cup\{x\}$ is $s_1,s_2,...s_n$ plus $s_1',s_2',...,s_n'$ where $s_k'=s_k\cup\{x\}(1\le k\le n)$.

# 2.33

```scheme
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
```

# 2.34

```scheme
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))
```

# 2.35

```scheme
(define (count-leaves t)
  (accumulate + 0 (map (lambda (tree)
                         (if (list? tree)
                             (count-leaves tree)
                             1))
                       t)))
```

# 2.36

```scheme
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))
```

# 2.37

```scheme
(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
           (matrix-*-vector cols x))
         m)))
```

# 2.38

When operator whee commutative.

# 2.39

```scheme
(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (append (list y) x)) nil sequence))
```

# 2.40

```scheme
(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))
```

# 2.41

```scheme
(define (unique-triples n)
  (flatmap
   (lambda (i)
     (flatmap (lambda (j)
            (map (lambda (k) (list i j k))
                 (enumerate-interval 1 (- j 1))))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (sum-s-triples s n)
  (define (ok? triple)
    (= s (+ (car triple) (cadr triple) (caddr triple))))
  (filter ok? (unique-triples n)))
```

# 2.42

I need some time...

# 2.43

I need some time...

# 2.44

```scheme
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
```

# 2.45

```scheme
(define (split dir1 dir2)
  (define (split-n painter n)
    (if (= n 0)
        painter
        (let ((smaller (split-n  painter (- n 1))))
          (dir1 painter (dir2 smaller smaller)))))
  (lambda (painter n)
    (split-n painter n)))

(define r-split (split beside below))
(define u-split (split below beside))
```

# 2.46

```scheme
(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)
(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect s v)
  (make-vect (* (xcor-vect v) s)
             (* (ycor-vect v) s)))
```

# 2.47

```scheme
(define origin-frame car)
(define edge1-frame cadr)
(define edge2-frame caddr)

(define origin-frame car)
(define edge1-frame cadr)
(define edge2-frame cddr)
```

# 2.48

Why does he so love exercises like cons/car/cdr...

```scheme
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)
```

# 2.49

```scheme
(define (segment->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segment-list)))

(define (draw-outline frame)
  ((segments->painter 
     (list (make-segment (make-vect 0 0)
                         (make-vect 0 1))
           (make-segment (make-vect 0 1)
                         (make-vect 1 1))
           (make-segment (make-vect 1 1)
                         (make-vect 1 0))
           (make-segment (make-vect 1 0)
                         (make-vect 0 0))))
   frame))

(define (draw-x frame)
  ((segments->painter
     (list (make-segment (make-vect 0 0)
                         (make-vect 1 1))
           (make-segment (make-vect 1 0)
                         (make-vect 0 1))))
   frame))
```

WTF is the wave...

# 2.50

```scheme
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (rotate-180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate-270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))
```

# 2.51

```scheme
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-up
            (transform-painter painter1
                               (make-vect 0.0 0.0)
                               (make-vect 1.0 0.0)
                               split-point))
          (paint-down
            (transform-painter painter2
                               split-point
                               (make-vect 1.0 0.5)
                               (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-up frame)
        (print-down frame)))))

(define (below painter1 painter2)
  (rotate-270 (beside (rotate-90 painter1) (rotate-90 painter-2))))
```

# 2.52

```scheme
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (corner (corner-split painter (- n 1))))
        (beside (below up painter)
                (below corner right)))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four identity flip-horiz
                                  flip-vert rotate180)))
    (combine4 (corner-split painter n))))
```
# 2.53

```scheme
(list 'a 'b 'c)
; (a b c)
(list (list 'george))
; ((george))
(cdr '((x1 x2) (y1 y2)))
; ((y1 y2))
(cadr '((x1 x2) (y1 y2)))
; (y1 y2)
(pair? (car '(a short list)))
; #f
(memq 'red '((red shoes) (blue socks)))
; #f
(memq 'red '(red shoes blue socks))
; (red shoes blue socks)
```

# 2.54

```scheme
(define (equal? x y)
  (cond ((and (pair? x) (pair? y))
         (and (equal? (car x) (car y))
              (equal? (cdr x) (cdr y))))
        ((and (symbol? x) (symbol? y))
         (eq? x y))
        ((null? x) (null? y))
        (else #f)))
```

only work for list and symbols

# 2.55

Because `''abracadabra` means (quote (quote (abracadabra))), so her types `(car ''abracadabra)` means `(car (quote (quote (abracadabra))))`, which is quote.

# 2.56

```scheme
(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))
(define (base s) (cadr s))
(define (exponent s) (caddr s))
(define (make-exponentiation m1 m2)
  (cond ((or (=number? m1 1) (=number? m2 0)) 1)
        ((=number? m1 0) 0)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2))
         (expt m1 m2))
        (else (list '** m1 m2))))
```

# 2.57

```scheme
(define (make-sum a1 . a2)
  (append (list '+ a1) a2))
(define (make-product m1 . m2)
  (append (list '* m1) m2))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s)
  (if (> (length (cddr s)) 1)
      (append (list '+) (cddr s))
      (caddr s)))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier s) (cadr s))
(define (multiplicand s)
  (if (> (length (cddr s)) 1)
      (append (list'*) (cddr s))
      (caddr s)))
```

# 2.58

```scheme
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))


(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))


(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))
(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))
```

I need some time to solve subproblem b ...

# 2.59

```scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1) (union-set (cdr set1) set2)))))
```

# 2.60

```scheme
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (cons (car set1) (union-set (cdr set1) set2)))))
```

| procedure | order of growth |
|-|-|
| element-of-set? |$O(n)$ |
|adjoin-set|$O(1)$|
|intersection-set|$O(n^2)$|
|union-set|$O(n)$|

I'd like non-duplicate one, because even order of growth is worse than duplicate one, but size of set will grow far slower than duplicate one.

# 2.61

```scheme
(define (adjoin-set x set)
  (cond ((null? set) (cons x '()))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
```

# 2.62

```scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1)) (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1 (union-set (cdr set1) (cdr set2))))
                      ((< x1 x2)
                       (cons x1 (union-set (cdr set1) set2)))
                      ((> x1 x2)
                       (cons x2 (union-set set1 (cdr set2)))))))))
```

# 2.63

Same result, as same as in-order travel of binary tree.

Because of append, first one has time complexity $On\log n$, second one has time complexity $O(n)$.

`(1 2 3 4 5 6 7)`

# 2.64

Recursive is so magic.

```
    5
   / \
  3   9
 /   / \
1   7   11
```

Explaining it in induction is easy. First we assume it work well, then we can use it in its procedure body, then we should think about that if it's working well, how should we manipulate entry, left tree and right tree to construct new tree. I can use Python rewrite it as:

```python
def partial_tree(elts, size):
	if size == 0:
		return [], elts
	left_size = (size - 1) // 2
	left_tree, rest_of_left_elts = partial_tree(elts, left_size)
	entry = rest_of_left_elts.pop() # get first element and remove it
	right_tree, rest_elts = partial_tree(rest_of_left_elts, (size - left_size - 1))
	return Tree(entry, left_tree, right_tree), rest_elts
```

Because we only use every element one time, so it has time complexity of $O(n)$, space complexity of $O(n)$.

# 2.65

Because we have tree->list, intersection-set-list, union-set-list, list->tree, which all have complexity of $O(n)$, so we just need to combine them.

I have no interests in assemble them, so :p

# 2.66

```scheme
define (lookup given-key set-of-records)
  (if (null? set-of-records)
      #f
      (let ((record (entry set-of-records)))
        (let ((k (key record)))
          (cond ((= given-key k) (record))
                ((< given-key k)
                 (lookup given-key (left-branch set-of-records)))
                (else
                 (lookup given-key (right-branch set-of-records))))))))
```

# 2.67

```scheme
> (decode sample-message sample-tree)
(A D A B B C A)
```

# 2.68

```scheme
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (has-symbol? symbol symbol-list)
    (not (equal? #f (memq symbol symbol-list))))
  (if (has-symbol? symbol (symbols tree))
      (let ((left (left-branch tree))
            (right (right-branch tree)))
        (if (has-symbol? symbol (symbols left))
            (if (leaf? left)
                '(0)
                (cons 0 (encode-symbol symbol left)))
            (if (leaf? right)
                '(1)
                (cons 1 (encode-symbol symbol right)))))
      (error "Symbol not in tree")))
```

# 2.69

```scheme
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge tree)
  (if (null? (cdr tree))
      (car tree)
      (let ((left (car tree))
            (right (cadr tree))
            (rest (cddr tree)))
        (successive-merge 
          (adjoin-set (make-code-tree left right) 
                      rest)))))
```

# 2.70

```scheme
(encode '(GET A JOB) sample-tree)
; (1 1 1 1 1 1 1 0 0 1 1 1 1 0)
(encode '(SHA NA NA NA NA NA NA NA NA) sample-tree)
; (1 1 1 0 0 0 0 0 0 0 0 0)
(encode '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP) sample-tree)
; (1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
(encode '(SHA BOOM) sample-tree)
; (1 1 1 0 1 1 0 1 1)
```

84, 108

# 2.71

Drawing again? NO WAY...

1, n-1.

# 2.72

Worst case is at situations like 2.71, so this procedure has time complexity of $O(n^2)$.

When every symbol have same frequency, every symbol can be the most frequent symbol, so the worst case happen when encoding right most symbol, so this procedure has time complexity of $O(n\log n)$ **I guess**.

# 2.73

a. If expression is a number of variable, just reture derivative according rule, if not, get derivative rule and apply with variable. Because number and variable doesn't have a type tag I guess.

b.

```scheme
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) 
                                           var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (install-sum-deriv-package)
  (define (make-sum a1 . a2)
    (append (list '+ a1) a2))
  (define (addend s) (cadr s))
  (define (augend s)
    (if (> (length (cddr s)) 1)
        (append (list '+) (cddr s))
        (caddr s)))
  (define (deriv exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))

  (define (tag x) (attach-tag 'sum x))
  (put 'make-sum '(sum) make-sum)
  (put 'addend '(sum) addend)
  (put 'augend '(sum) augend)
  (put 'deriv '(sum) deriv)
  'done)

(define (install-product-deriv-package)
  (define (make-product a1 . a2)
    (append (list '* a1) a2))
  (define (multiplier s) (cadr s))
  (define (multiplicand s)
    (if (> (length (cddr s)) 1)
        (append (list'*) (cddr s))
        (caddr s)))
  (define (deriv exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicand exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))

  (define (tag x) (attach-tag 'product x))
  (put 'make-product '(product) make-product)
  (put 'multiplier '(product) multiplier)
  (put 'multiplicand '(product) multiplicand)
  (put 'deriv '(product) deriv)
  'done)
```

c.

```scheme
(define (install-exponentiation-package)
  (define (make-exponentiation b e)
    (cond ((=number? e 0) 1)
          ((=number? e 1) b)
          ((and (number? b) (number? e)) (expt b e))
          (else (list '** b e))))
  (define (base operands) (car operands))
  (define (exponent operands) (cadr operands))
  (define (deriv-exponentiation operands var)
    (make-product
      (exponent operands)
      (make-product
        (make-exponentiation
          (base operands)
          (- (exponent exp) 1))
        (deriv (base exp)))))
  
  (define (tag x) (attach-tag 'exponentiation x))
  (put 'make-exponentiation '(exponentiation) make-product)
  (put 'base '(exponentiation) multiplier)
  (put 'exponent '(exponentiation) multiplicand)
  (put 'deriv '(exponentiation) deriv-exponentiation)
  'done)
```

d. I think all deriv put statements needs to be changed into the same indexing.

# 2.74

```scheme
(define (make-generic-employee-file division employee-file)
  (cons division employee-file))
(define (division generic-employee-file)
  (car generic-employee-file))
(define (employee-file generic-employee-file)
  (cdr generic-employee-file))

(define (get-record employee-name generic-employee-file)
  ((get 'get-record (division generic-employee-file))
     employee-name
     (employee-file generic-employee-file)))

(define (get-salary generic-employee-record)
  ((get 'get-salary (division generic-employee-record))
     (employee-record generic-employee-record)))

(define (find-employee-record employee-name generic-files)
  (if (null? generic-files)
      (error "Record not found")
      (let ((record (get-record employee-name (car generic-files))))
        (if (record)
            record
            (find-employee-record employee-name (cdr generic-files))))))
```

Every division must write their own getter for their data.

# 2.75

```scheme
(define (make-from-mag-ang r a)
  (define (dispath op)
    (cond ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          ((eq? op 'real-part)
           (* r (cos a)))
          ((eq? op 'imag-part)
           (* r (sin a)))
          (else
            (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispath)
```

# 2.76

|name|add new type|add new operation|
|-|-|-|
|generic operations with explicit dispatch|add new branch of new type for all procedures|create operation containe dispatch of all the types|
|data-directed programming|registry new type in table|define operation in each type and add a generic operation|
|message-passing programming|just implement new type|add operation for each type|

If we need to frequently add new type, we should use data-directed programming or message-passing programming.

If we need to frequently add new operation, we should use generic operations with dispatch or data-directed programming.

Because data-directed use more of modularity, so I prefer it.

# 2.77

```scheme
;; (magnitude z)
;; (magnitude (make-complex-from-real-imag 3 4))
;; (magnitude ((get 'make-from-real-imag 'complex) 3 4))
;; (magnitude (tag (make-from-real-imag 3 4)))
;; (magnitude (attach-tag 'complex (make-from-real-imag 3 4)))
;; (magnitude (attach-tag 'complex (get 'make-from-real-imag 'rectangular) 3 4))
;; (magnitude (attach-tag 'complex (tag (make-from-real-imag 3 4))))
;; (magnitude (attach-tag 'complex (attach-tag 'rectangular (cons 3 4))))
;; (magnitude (cons 'complex (cons 'rectangular (cons 3 4))))
;; (magnitude '(complex rectangular 3 4))
;; (apply-generic 'magnitude '(complex rectangular 3 4))
;; (magnitude '(rectangular 3 4))
;; (apply-generic 'magnitude '(rectangular 3 4))
;; (magnitude '(3 4))
;; 5

;; `apply-generic' is invoked 2 times
```

# 2.78

```scheme
(define (attach-tag type-tag contents)
  (if (number? contents)
      contents
      (cons type-tag contents))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) datum)
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else (error "Bad tagged datum -- CONTENTS" datum))))
```

# 2.79

```scheme
(define (equ? x y)
  (apply-generic 'equ? x y))

(put 'equ? '(scheme-number scheme-number) =)

(put 'equ? '(rational rational)
     (lambda (x y) 
       (= (* (numer x)
             (denom y))
          (* (denom x)
             (number y)))))

(put 'equ? '(complex complex)
     (lambda (x y)
       (and (= (real-part x)
               (real-part y))
            (= (imag-part x)
               (imag-part y)))))
```

# 2.81

```scheme
(define (=zero? v) 
  (apply-generic '=zero? v))

(put '=zero? (scheme-number) 
     (lambda (v)
       (= v 0)))

(put '=zero? (rational)
     (lambda (v)
       (= 0 (numer v))))

(put '=zero? (rational)
     (lambda (v)
       (= 0 (magnitude v))))
```

# 2.82

a. `apply-generic` will call itself recursively when successful corecion, so `apply-generic` should always fall into infinite loop.

b. `apply-generic` works correctly as is.

c. 

```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (equal? type1 type2) ;; <--- determine the type equality
                    (error "No method for these types"
                           (list op type-tags))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                              (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                              (apply-generic op a1 (t2->t1 a2)))
                            (else
                              (error "No method for these types"
                                     (list op type-tags)))))))
              (error "No method for these types"
                     (list op type-tags)))))))
```