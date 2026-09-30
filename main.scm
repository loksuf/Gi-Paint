#!/usr/bin/env -S guile
!#

(add-to-load-path (dirname (current-filename)))
(use-modules (raylib))
(use-modules (consts))
(use-modules (colors))
(use-modules (primitives))
(use-modules (canvas))

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

(define current_tool "stamp")

(define stamp_switch #t)

; Render frame
(define (render_frame)
    ; Body
  (begin
    (begin_drawing) ; PYRAMID OF DOOM :skull: :skull: :skull: :skull: :skull: :skull: 
    (clear_background theme_background)
    (cond
      (
        (= (is_mouse_button_down MOUSE_BUTTON_LEFT) 1)
        (cond
          (
            (string=? current_tool "stamp")
            (if 
              stamp_switch
              (begin
                (set! stamp_switch #f)
                 
                (let
                  (
                    (blot (make_blot (get_mouse_x) (get_mouse_y) 15.8 (rgba_struct 255 0 0 255)))
                  )
                  (canvas_draw_abstract "blot" blot)
                )
              )
            )
          )
        )
      )
      (else
        (set! stamp_switch #t)
      )
    )
    (canvas_render)
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
    (canvas_load)
    (start_render_loop)
  )
)

(main)
