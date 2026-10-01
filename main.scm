#!/usr/bin/env -S guile
!#

(add-to-load-path (dirname (current-filename)))
(use-modules (raylib))
(use-modules (consts))
(use-modules (colors))
(use-modules (primitives))
(use-modules (ui canvas))
(use-modules (ui ui_core))
(use-modules (ui toolbar))
(use-modules (ui erase_mode_bridge))

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

(define key_e_blocker #f)
(define key_f_blocker #f)
(define key_b_blocker #f)
(define key_s_blocker #f)

; Render frame
(define (render_frame)
  ; Body

  ; Keyboard interactions handler
  (begin
    (if
      (= (is_key_pressed KEY_E) 1)
      (if
        (not key_e_blocker)
        (begin
          (set_erase_mode (not (get_erase_mode)))
          (set! key_e_blocker #t)
        )
      )
      (set! key_e_blocker #f)
    )
    (if
      (= (is_key_pressed KEY_F) 1)
      (if
        (not key_f_blocker)
        (begin
          (change_current_tool "fill")
          (set! key_f_blocker #t)
        )
      )
      (set! key_f_blocker #f)
    )
    (if
      (= (is_key_pressed KEY_B) 1)
      (if
        (not key_b_blocker)
        (begin
          (change_current_tool "brush")
          (set! key_b_blocker #t)
        )
      )
      (set! key_b_blocker #f)
    )
    (if
      (= (is_key_pressed KEY_S) 1)
      (if
        (not key_s_blocker)
        (begin
          (change_current_tool "stamp")
          (set! key_s_blocker #t)
        )
      )
      (set! key_s_blocker #f)
    )
  )

  ; Mouse interactions handler
  (begin 
    (let
      (
        (mouse_pos_x (get_mouse_x))
        (mouse_pos_y (get_mouse_y))
      )
      (begin_drawing)
      (clear_background theme_background)
      (cond
        (
          (= (is_mouse_button_down MOUSE_BUTTON_LEFT) 1)
          (panels_ui_interact 
            (cons mouse_pos_x mouse_pos_y)
            "mouse"
            (list MOUSE_BUTTON_LEFT)
          )
        )
        (
          (= (is_mouse_button_down MOUSE_BUTTON_MIDDLE) 1)
          (if 
            (not 
              (panels_ui_interact
                (cons mouse_pos_x mouse_pos_y)
                "mouse"
                (list MOUSE_BUTTON_MIDDLE)
              )
            )
            (panels_ui_ghost_interact
              "canvas"
              "mouse"
              (list MOUSE_BUTTON_MIDDLE)
            )
          )
        )
        (else ; Spam is okay (not because I'm too lazy to fix it, but simply because it's a good solution, probably... :p )
          (panels_ui_ghost_interact
            "canvas"
            "mouse"
            (list MOUSE_BUTTON_NONE)
          )
          (panels_ui_ghost_interact
            "toolbar"
            "mouse"
            (list MOUSE_BUTTON_NONE)
          )
        )
      )
      (canvas_render (get_erase_mode))
      (toolbar_render)
      (end_drawing)
    )
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
    (init_window SCREEN_WIDTH SCREEN_HEIGHT (c_str APP_NAME))
    (set_target_fps FPS)
    (canvas_load)
    (toolbar_load)
    (panels_ui_add_collider 
      "canvas"
      canvas_area_callback 
      canvas_interact_callback)
    (panels_ui_add_collider 
      "toolbar"
      toolbar_area_callback 
      toolbar_interact_callback)
    (start_render_loop)
  )
)

(main)
