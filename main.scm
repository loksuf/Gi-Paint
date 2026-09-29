#!/usr/bin/env -S guile
!#

(define (make_color_rgb r g b) 
  (let 
    ((hex_red (* r 65536 ))
    (hex_green (* g 256)))
    (+ hex_red hex_green b)
  )
)

(newline)
(display (make_color_rgb 252 186 3))
(newline)

(define (make_point x y)
  (cons x y)
)

(define (move_point point xd yd)
  (let
    (
      (new_x (+ (car point) xd))
      (new_y (+ (cdr point) yd))
    )
    (
      cons new_x new_y
    )
  )
)

(define (print_point point)
  (begin 
    (display "x : ")
    (display (car point))
    (display " ; y : ")
    (display (cdr point))
    (newline)
  ) 
)


(define (proceed x y)
  (let
    (
      (point (make_point x y))
    )
    (print_point point)
    (display "moving...")
    (newline)
    (set! point (move_point point 4 10))
    (print_point point)
  )
)

(proceed 14 2)
