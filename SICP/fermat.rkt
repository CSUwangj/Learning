#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

(define (next a)
  (cond ((< a 2) 2)
        ((= a 2) 3)
        ((even? a) (+ a 1))
        (else (+ a 2))))

(define (square x) (* x x))

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

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

(fool-fermat 561)
(fool-fermat 1105)
(fool-fermat 1729)
(fool-fermat 2465)
(fool-fermat 2821)
(fool-fermat 6601)