#!/usr/bin/env -S guile
!#

(add-to-load-path (dirname (current-filename)))
(use-modules (system foreign))
(use-modules (raylib))
(use-modules (consts))

; - FUNCS

; On close
(define (on_close)
  (begin
    (display "Closing the process...")
    (newline)
    (close_window)
    (display "Exited!")
    (newline)
  )
)

; Render frame
(define (render_frame)
    ; Body
  (begin
    (begin_drawing)
    (end_drawing)
  )
)

; Render loop
(define (start_render_loop)
  (if (= (window_should_close) 0)
    (begin
      (render_frame)
      (start_render_loop)
    )
    (on_close)
 )
)

; ENTRY
(define (main)
  (begin
    (init_window SCREEN_WIDTH SCREEN_HEIGHT (c_str "PAINT"))
    (set_target_fps FPS)
    (start_render_loop)
  )
)

(main)
