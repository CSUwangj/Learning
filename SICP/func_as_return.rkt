#lang sicp

(define (double f)
  (lambda (x)
    (f (f x))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeat f n)
  (define (iter x result)
    (if (> x n)
        result
        (iter (+ x 1) (compose f result))))
  (iter 1 (lambda (x) x)))

(define (smooth dx)
  (lambda (f)
    (lambda (x)
      (/ (+ (f (- x dx))
            (f (x))
            (f (+ x dx)))
         3))))

(define smooth-inst (smooth 0.00001))

(expt 1 2)

