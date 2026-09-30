(define-module
  (canvas_data) ; Module name
)


(add-to-load-path (dirname (current-filename)))
(use-modules (primitives))

(define-public canvas_storage '())

; Capture blot
(define-public (capture_blot blot)
  (begin
    (display (blot_get_radius blot))
    (newline)
    (display "FKJSDGKJJFSDKGJJKJFGKS CATCAT")
    (newline)
  )
)
