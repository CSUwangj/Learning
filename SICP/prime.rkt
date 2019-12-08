#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

(define (square x) (* x x))

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (next a)
  (cond ((< a 2) 2)
        ((= a 2) 3)
        ((even? a) (+ a 1))
        (else (+ a 2))))

(define (search-for-primes a b)
  (cond ((< a b) (cond ((prime? a) (timed-prime-test a)))))
  (cond ((< a b) (search-for-primes (next a) b))))

(runtime)

(search-for-primes 1000000 1000100)

(runtime)