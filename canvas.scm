(define-module
  (canvas) ; Module name
)

(add-to-load-path (dirname (current-filename)))
(use-modules (primitives))
(use-modules (raylib))

(define-public canvas_storage '())

; draw_blot_from_struct
(define-public
  (draw_blot_from_struct blot)
  (draw_circle (blot_get_x blot) (blot_get_y blot) (blot_get_radius blot) (blot_get_rgba blot) )
)

; Rendering the entire canvas_storage
(define-public
  (canvas_render canvas_storage_list)
  (if
    (not (null? canvas_storage_list))
    (begin
      (draw_blot_from_struct (car canvas_storage_list))
      (canvas_render (cdr canvas_storage_list))
    )
  )
)

; Capture blot
(define-public (capture_blot blot)
  (begin
    (set! canvas_storage (cons blot canvas_storage))
  )
)
