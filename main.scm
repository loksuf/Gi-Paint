#!/usr/bin/env -S guile
!#

(add-to-load-path (dirname (current-filename)))
(use-modules (raylib))
(use-modules (consts))
(use-modules (colors))
(use-modules (primitives))
(use-modules (canvas_data))

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
    (clear_background theme_background)
    (if
      (= (is_mouse_button_down MOUSE_BUTTON_LEFT) 1)
      (
        draw_circle
          (get_mouse_x)
          (get_mouse_y)
          15.8
          (rgba_struct 255 0 0 255)
      )
    )
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
(define my-blot (make_blot 10 20 50 (rgba_struct 255 0 0 255)))

;; 2. Передаем именно объект my-blot в геттер:
(display (blot_get_radius my-blot)) ; Выведет: 50
(newline)
    (init_window SCREEN_WIDTH SCREEN_HEIGHT (c_str "PAINT"))
    (set_target_fps FPS)
    (start_render_loop)
  )
)

(main)
