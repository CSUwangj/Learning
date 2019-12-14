#lang sicp

(define (last-pair items)
  (if (null? (cdr items))
      (car items)
      (last-pair (cdr items))))

(define (reverse items)
  (define (iter current-item rest-items)
    (if (null? rest-items)
        current-item
        (iter (cons (car rest-items) current-item)
              (cdr rest-items))))
  (iter nil items))

(reverse (list 23 72 149 34))