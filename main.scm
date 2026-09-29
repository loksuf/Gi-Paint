#!/usr/bin/env -S guile
!#


(display (- (* 15 4) 12))
(display "\n")
(display (+ (/ 100 5) 15))
(display "\n")
(display (- (* (+ 8 2) (+ 3 7)) 50) )
(display "\n")
(display (/ 3 4))
(display "\n")

(define pi 3.14159)

(define (circle_area radius) (* pi (* radius radius)))
(define (perim w h) (* 2 (+ w h)))
(display (circle_area 6))
(display "\n")
(display (perim 4 6))

(display "\n\nmax_num\n")
(define (max_num a b) (if (> a b) a b))
(display (max_num 14 15))
(display "\n")
(display (max_num 15 15))
(display "\n")
(display (max_num 16 15))

(display "\n\nclamp\n")
(define (clamp val min_val max_val) 
  (cond 
    ((< val min_val) min_val)
    ((> val max_val) max_val)
    (else val)
  ))

(display (clamp 4 1 5))
(display "\n")
(display (clamp 0 1 5))
(display "\n")
(display (clamp 6 1 5))
(display "\n")
