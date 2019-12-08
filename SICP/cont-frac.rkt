#lang sicp

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

(+ 2 (cout-frac-iter (lambda (i) 1.0)
           (lambda (i)
             (if (= (remainder i 3) 1)
                 (* 2 (/ (+ i 2) 3))
                 1))
           102))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x) (* x x))

(define (exp base expo)
  (cond ((= expo 0) 1)
        ((even? expo)
         (square (exp base (/ expo 2))))
        (else
         (* base (exp base (- expo 1))))))

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

(tan-cf 1.0 100)