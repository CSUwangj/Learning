#lang racket

( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

(paint einstein)

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (split dir1 dir2)
  (define (split-n painter n)
    (if (= n 0)
        painter
        (let ((smaller (split-n  painter (- n 1))))
          (dir1 painter (dir2 smaller smaller)))))
  (lambda (painter n)
    (split-n painter n)))

(define r-split (split beside below))
(define u-split (split below beside))

(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)
(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect s v)
  (make-vect (* (xcor-vect v) s)
             (* (ycor-vect v) s)))

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

(define (segment->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segment-list)))

(define (draw-outline frame)
  ((segments->painter 
     (list (make-segment (make-vect 0 0)
                         (make-vect 0 1))
           (make-segment (make-vect 0 1)
                         (make-vect 1 1))
           (make-segment (make-vect 1 1)
                         (make-vect 1 0))
           (make-segment (make-vect 1 0)
                         (make-vect 0 0))))
   frame))

(define (draw-x frame)
  ((segments->painter
     (list (make-segment (make-vect 0 0)
                         (make-vect 1 1))
           (make-segment (make-vect 1 0)
                         (make-vect 0 1))))
   frame))

(draw-x 1)