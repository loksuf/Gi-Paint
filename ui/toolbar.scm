(define-module
  (ui toolbar) ; Module name
)

(define toolbar_ui_collisions '())

(define
  (tuc_push_front data)
  (set! toolbar_ui_collisions (cons data toolbar_ui_collisions))
)

(use-modules (consts))
(use-modules (colors))
(use-modules (raylib))
(use-modules (ui canvas))
(use-modules (ui ui_core))
(use-modules (ui erase_mode_bridge))

(define erase_mode_icon_tex #f)
(define brush_icon_tex #f)
(define stamp_icon_tex #f)
(define fill_icon_tex #f)

(define ICON_SRCWH 64)
(define ICON_WH (inexact->exact (round (* TOOLBAR_WIDTH 0.65))))
(define ICON_PADDING (inexact->exact (round (* 0.5 (- TOOLBAR_WIDTH ICON_WH)))))
(define ICON_BG_PADDING (inexact->exact (round (* ICON_PADDING 0.5))))
(define ICON_BG_WH (inexact->exact (+ ICON_BG_PADDING ICON_WH)))

(define (render_button tex index selected)
  (begin
    (let
      (
        (icon_bg_color THEME_SEL_ICON_BG)
      )
      (if
        (not selected)
        (set! icon_bg_color THEME_ICON_BG)
      )
      (draw_rectangle ICON_BG_PADDING (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) index)) ICON_BG_WH ICON_BG_WH icon_bg_color)
        (draw_texture_pro
        tex
        (make_c_rectangle 0 0 ICON_SRCWH ICON_SRCWH)
        (make_c_rectangle ICON_PADDING (+ (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) index)) 2) ICON_WH ICON_WH) ; pzdc ◕_◕
        (make_c_vector2 0 0)
        0.0
        (rgba_struct 255 255 255 255)
      )
    )
  )
)

(define (render_color_button color index selected)
  (begin
    (let
      (
        (icon_bg_color THEME_SEL_ICON_BG)
      )
      (if
        (not selected)
        (set! icon_bg_color THEME_ICON_BG)
      )
      (draw_rectangle ICON_BG_PADDING (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) index)) ICON_BG_WH ICON_BG_WH icon_bg_color)
      (draw_rectangle ICON_PADDING (+ (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) index)) 2) ICON_WH ICON_WH color)
    )
  )
)

; Interaction callback factory for buttons
(define (make_inter_callback real_callback)
  (lambda (hit_pos inter_type inter_data)
    (real_callback)
  )
)

; Area callback factory for buttons
(define (make_area_callback index)
  (lambda ()
    (let*
      (
        (hell_y (+ (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) index )) 2))
        (x0 0)
        (y0 hell_y)
        (x3 TOOLBAR_WIDTH)
        (y3 (+ (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) (+ index 1))) 2)) ; It’s terrible, it’s ugly, 
                                                                                                      ; but it works, and I don’t want to know how (╥﹏╥)
      )
      (list (cons x0 y0) (cons x3 y3))
    )
  )
)

; Area callback
(define-public
  (toolbar_area_callback)
  (list
    (cons 
      0
      0
    )
    (cons
      TOOLBAR_WIDTH
      SCREEN_HEIGHT
    )
  )
)

(define repeat_block #f)

; Interact callback_mouse
(define-public
  (toolbar_interact_callback hit_pos interaction_type interaction_data)
  (if
    (= (car interaction_data) MOUSE_BUTTON_LEFT)
    (if
      (not repeat_block)
      (begin
        (ui_interact hit_pos interaction_type interaction_data toolbar_ui_collisions)
        (set! repeat_block #t)
      )
    )
    (set! repeat_block #f)
  )
)

; Toolbar loader
(define-public
  (toolbar_load)
  (begin
    (set! erase_mode_icon_tex (load_texture_from_file ICON_ERASE_MODE_PATH))
    (set! brush_icon_tex (load_texture_from_file ICON_BRUSH_PATH))
    (set! stamp_icon_tex (load_texture_from_file ICON_STAMP_PATH))
    (set! fill_icon_tex (load_texture_from_file ICON_FILL_PATH))
    (tuc_push_front (list "erase_mode" (make_area_callback 0) (make_inter_callback (lambda () (set_erase_mode (not (get_erase_mode))) )) ))
    (tuc_push_front (list "stamp" (make_area_callback 1) (make_inter_callback (lambda () (change_current_tool "stamp") )) ))
    (tuc_push_front (list "brush" (make_area_callback 2) (make_inter_callback (lambda () (change_current_tool "brush") )) ))
    (tuc_push_front (list "fill" (make_area_callback 3) (make_inter_callback (lambda () (change_current_tool "fill") )) ))
    (tuc_push_front (list "bg_red" (make_area_callback 4) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_BG_RED) )) ))
    (tuc_push_front (list "red" (make_area_callback 5) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_RED) )) ))
    (tuc_push_front (list "pink" (make_area_callback 6) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_PINK) )) ))
    (tuc_push_front (list "purple" (make_area_callback 7) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_PURPLE) )) ))
    (tuc_push_front (list "blue" (make_area_callback 8) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_BLUE) )) ))
    (tuc_push_front (list "cyan" (make_area_callback 9) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_CYAN) )) ))
    (tuc_push_front (list "green" (make_area_callback 10) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_GREEN) )) ))
    (tuc_push_front (list "yellow" (make_area_callback 11) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_YELLOW) )) ))
    (tuc_push_front (list "orange" (make_area_callback 12) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_ORANGE) )) ))
    (tuc_push_front (list "white" (make_area_callback 13) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_WHITE) )) ))
    (tuc_push_front (list "grey" (make_area_callback 14) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_GREY) )) ))
    (tuc_push_front (list "black" (make_area_callback 15) (make_inter_callback (lambda () (set_current_color COLOR_BUTTON_BLACK) )) ))
  )
)

; Toolbar render
(define-public
  (toolbar_render)
  (begin
    (draw_rectangle 0 0 TOOLBAR_WIDTH SCREEN_HEIGHT THEME_TOOLBAR_BG)
    (draw_rectangle (- TOOLBAR_WIDTH 2) 0 2 SCREEN_HEIGHT THEME_SHADOW)
    
    (render_button erase_mode_icon_tex 0 (get_erase_mode))
    (render_button stamp_icon_tex 1 (string=? (get_current_tool) "stamp"))
    (render_button brush_icon_tex 2 (string=? (get_current_tool) "brush"))
    (render_button fill_icon_tex 3 (string=? (get_current_tool) "fill"))
    (render_color_button COLOR_BUTTON_BG_RED 4 (= (get_current_color) COLOR_BUTTON_BG_RED))
    (render_color_button COLOR_BUTTON_RED 5 (= (get_current_color) COLOR_BUTTON_RED))
    (render_color_button COLOR_BUTTON_PINK 6 (= (get_current_color) COLOR_BUTTON_PINK))
    (render_color_button COLOR_BUTTON_PURPLE 7 (= (get_current_color) COLOR_BUTTON_PURPLE))
    (render_color_button COLOR_BUTTON_BLUE 8 (= (get_current_color) COLOR_BUTTON_BLUE))
    (render_color_button COLOR_BUTTON_CYAN 9 (= (get_current_color) COLOR_BUTTON_CYAN))
    (render_color_button COLOR_BUTTON_GREEN 10 (= (get_current_color) COLOR_BUTTON_GREEN))
    (render_color_button COLOR_BUTTON_YELLOW 11 (= (get_current_color) COLOR_BUTTON_YELLOW))
    (render_color_button COLOR_BUTTON_ORANGE 12 (= (get_current_color) COLOR_BUTTON_ORANGE))
    (render_color_button COLOR_BUTTON_WHITE 13 (= (get_current_color) COLOR_BUTTON_WHITE))
    (render_color_button COLOR_BUTTON_GREY 14 (= (get_current_color) COLOR_BUTTON_GREY))
    (render_color_button COLOR_BUTTON_BLACK 15 (= (get_current_color) COLOR_BUTTON_BLACK))
  )
)
