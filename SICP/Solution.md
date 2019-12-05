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

And it's obvious that $|1-\sqrt{5}|<2$, so $\lim_{x\to\inf}\psi ^x=0.$ Which means $Fib(n)$ is the closest integer to $\frac{\phi ^n}{\sqrt{5}}$.