#lang sicp

(define new-cons
  (lambda (x y)
    (lambda (f) (f x y))))
(define new-car
  (lambda (f)
    (f (lambda (x y) y))))
(define new-cdr
  (lambda (f)
    (f (lambda (x y) y))))

(define a (new-cons 1 2))
(new-cdr a)
(new-car a)

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
(define aa (arith-cons 0 2))
aa
(arith-car aa)
(arith-cdr aa)