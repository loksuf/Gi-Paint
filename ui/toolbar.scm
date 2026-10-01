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

(define brush_icon_tex #f)
(define stamp_icon_tex #f)
(define fill_icon_tex #f)

(define ICON_SRCWH 64)
(define ICON_WH (* TOOLBAR_WIDTH 0.65))
(define ICON_PADDING (* 0.5 (- TOOLBAR_WIDTH ICON_WH)))
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
        (y3 (+ (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) (+ index 1))) 2))
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

; Interact callback_mouse
(define-public
  (toolbar_interact_callback hit_pos interaction_type interaction_data)
  (ui_interact hit_pos interaction_type interaction_data toolbar_ui_collisions)
)

; Toolbar loader
(define-public
  (toolbar_load)
  (begin
    (set! brush_icon_tex (load_texture_from_file ICON_BRUSH_PATH))
    (set! stamp_icon_tex (load_texture_from_file ICON_STAMP_PATH))
    (set! fill_icon_tex (load_texture_from_file ICON_FILL_PATH))
    (tuc_push_front (list "stamp" (make_area_callback 0) (make_inter_callback (lambda () (change_current_tool "stamp") )) ))
    (tuc_push_front (list "brush" (make_area_callback 1) (make_inter_callback (lambda () (change_current_tool "brush") )) ))
    (tuc_push_front (list "fill" (make_area_callback 2) (make_inter_callback (lambda () (change_current_tool "fill") )) ))
  )
)

; Toolbar render
(define-public
  (toolbar_render)
  (begin
    (draw_rectangle 0 0 TOOLBAR_WIDTH SCREEN_HEIGHT THEME_TOOLBAR_BG)
    (draw_rectangle (- TOOLBAR_WIDTH 2) 0 2 SCREEN_HEIGHT THEME_SHADOW)
    
    (render_button stamp_icon_tex 0 (string=? (get_current_tool) "stamp"))
    (render_button brush_icon_tex 1 (string=? (get_current_tool) "brush"))
    (render_button fill_icon_tex 2 (string=? (get_current_tool) "fill"))
  )
)
