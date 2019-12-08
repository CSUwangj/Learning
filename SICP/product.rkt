#lang sicp

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

(define (factorial n)
  (define (term x)
    (cond ((> x 0) x)
          (else 1)))
  (define (inc a)
    (+ 1 a))
  (product term 0 inc n))

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

(pi 10000)
  