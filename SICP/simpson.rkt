#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

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
(simpson cube 0 1 100)
(integral cube 0 1 0.001)
(simpson cube 0 1 1000)