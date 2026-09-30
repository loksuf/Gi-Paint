(define-module
  (primitives) ; Module name
  #:use-module (srfi srfi-9)
  #:export (
    point?
    make_point
    point_get_x
    point_get_y
    point_set_x!
    point_set_y!
    bolt?
    make_blot
    blot_get_x 
    blot_get_y
    blot_set_x!
    blot_set_y!
    blot_get_radius
    blot_set_radius!
    blot_get_rgba
    blot_set_rgba!
  )
)

; Make point
(define-record-type point_type
  (make_point x y)
  point?
  (x point_get_x point_set_x!)
  (y point_get_y point_set_y!)
)

; Make blot
(define-record-type blot_type
  (make_blot x y radius rgba)
  blot?
  (x blot_get_x blot_set_x!)
  (y blot_get_y blot_set_y!)
  (radius blot_get_radius blot_set_radius!)
  (rgba blot_get_rgba blot_set_rgba!)
)
