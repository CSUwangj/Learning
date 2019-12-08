#lang sicp

(define (double f)
  (lambda (x)
    (f (f x))))

(define add-two (double inc))

(((double (double double)) inc) 5)