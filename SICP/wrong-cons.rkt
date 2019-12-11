#lang sicp

(define new-cons
  (lambda (x y)
    (lambda (f) (f x y))))
(define new-car
  (lambda (x y) x))
(define new-cdr
  (lambda (x y) y))

(define a (new-cons 1 2))
(a new-cdr)
(a new-car)

