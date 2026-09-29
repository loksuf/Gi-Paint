#!/usr/bin/env -S guile
!#

; `() - empty list

(define (make_color_rgb r g b) 
  (let 
    ((hex_red (* r 65536 ))
    (hex_green (* g 256)))
    (+ hex_red hex_green b)
  )
)

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

; ------

(define (get_first_x lst)
  (car (car lst) )
)

(define lst
  (list 
    (make_point 8 2)
    (make_point 3 4)
  )
)

(newline)
(display (get_first_x lst))
(newline)

(newline)
(display "begin side===")
(newline)

(define (draw_line_x_rec_ x1 x2 y cur_x_ cur_y_)
  (if 
    (> x1 x2)
    (begin
      (newline)
      (display "done!")
      (newline)
    )
    (if 
      (not (= cur_y_ y))
      (begin ; cur_y_ != y
        (newline)
        (draw_line_x_rec_ x1 x2 y cur_x_ (+ cur_y_ 1))
      )
      (cond ; cur_y_ == y
        (
          (< cur_x_ x1)
          (begin
            (display " ")
            (draw_line_x_rec_ x1 x2 y (+ cur_x_ 1) cur_y_)
          )
        )
        (
          (and (>= cur_x_ x1) (<= cur_x_ x2))
          (begin
            (display "*")
            (draw_line_x_rec_ x1 x2 y (+ cur_x_ 1) cur_y_)
          )
        )
        (else 
          (begin
            (newline)
            (display "done!")
            (newline)
          )
        )
      )
    )
  )
)

(define (draw_line_x x1 x2 y)
  (draw_line_x_rec_ x1 x2 y 0 0)
)

(draw_line_x 10 20 4)
