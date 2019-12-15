#lang sicp

(define (square a)
  (* a a))

(define (for-each proc items)
  (cond ((null? items) #t)
      (else
       (proc (car items))
       (for-each proc (cdr items)))))

(define x (list (list 1 2) (list 3 4)))
(define y (list 4 5 6))


(define (deep-reverse items)
  (define (iter current-items rest-items)
    (if (null? rest-items)
        current-items
        (iter (cons (if (list? (car rest-items))
                        (deep-reverse (car rest-items))
                        (car rest-items))
                    current-items)
              (cdr rest-items))))
  (iter nil items))

(define (fringe items)
  (cond ((null? items) nil)
        ((not (list? items)) (list items))
        (else (append (fringe (car items))
                      (fringe (cdr items))))))
(fringe (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

(define mobile? list?)
(define (total-weight mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (+ (if (mobile? left)
           (total-weight left)
           (branch-structure left))
       (if (mobile? right)
           (total-weight right)
           (branch-structure right)))))

(define (balanced mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (* (branch-length left) (total-weight left))
            (* (branch-length right) (total-weight right)))
         (if (mobile? left)
             (balanced left)
             #t)
         (if (mobile? right)
             (balanced right)
             #t))))

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (tree-map f tree)
  (cond ((null? tree) nil)
        ((not (list? tree)) (f tree))
        (else (cons (tree-map f (car tree))
                    (tree-map f (cdr tree))))))

(tree-map (lambda (x) (* x x)) (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(list 1 2 3)

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (x)
                       (cons (car s) x))
                     rest)))))
(subsets (list 1 2 3))
