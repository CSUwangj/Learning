#lang sicp


(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (tree)
                         (if (list? tree)
                             (count-leaves tree)
                             1))
                       t)))

(map (lambda (x) (* x x)) (list 3 3 3))
(append (list 1 2 3 4) (list 3 4 5 6))
(length (list 1 2 3 4))
(horner-eval 2 (list 1 3 0 5 0 1))
(count-leaves (list (list 1 2 3) (list 2 3 4) (list 1 2 3)))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))
(define (reversel sequence)
  (fold-left (lambda (x y) (append (list y) x)) nil sequence))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))