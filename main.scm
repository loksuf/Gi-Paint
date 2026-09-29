#!/usr/bin/env -S guile
!#

; `() - empty list

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

; ------

(define (render_points_list history)
  (if
    (null? history)
    (display "All points rendered!\n")
    (begin
      (print_point (car history))
      (render_points_list (cdr history))
    )
  )
)

(define (add_point lst point)
  (cons point lst)
)

(define simulated_paint_session
  (let
    (
      (history '())
    )
    (set! history (add_point history (make_point 10 10)))
    (set! history (add_point history (make_point 11 12)))
    (set! history (add_point history (make_point 12 14)))
    (render_points_list history)
  )
)
