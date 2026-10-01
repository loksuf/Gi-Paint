(define-module
  (ui toolbar) ; Module name
)

(use-modules (consts))
(use-modules (colors))
(use-modules (raylib))

(define brush_icon_tex #f)
(define ICON_SRCWH 64)
(define ICON_WH (* TOOLBAR_WIDTH 0.65))
(define ICON_PADDING (* 0.5 (- TOOLBAR_WIDTH ICON_WH)))
(define ICON_BG_PADDING (inexact->exact (round (* ICON_PADDING 0.5))))
(define ICON_BG_WH (inexact->exact (+ ICON_BG_PADDING ICON_WH)))

(define (render_button tex index selected)
  (begin
    (draw_rectangle ICON_BG_PADDING (+ ICON_BG_PADDING (* (+ ICON_BG_PADDING ICON_BG_PADDING ICON_BG_WH) index)) ICON_BG_WH ICON_BG_WH THEME_SEL_ICON_BG)
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

; Toolbar loader
(define-public
  (toolbar_load)
  (begin
    (set! brush_icon_tex (load_texture_from_file ICON_BRUSH_PATH))
  )
)

; Toolbar render
(define-public
  (toolbar_render)
  (begin
    (draw_rectangle 0 0 TOOLBAR_WIDTH SCREEN_HEIGHT THEME_TOOLBAR_BG)
    (draw_rectangle (- TOOLBAR_WIDTH 2) 0 2 SCREEN_HEIGHT THEME_SHADOW)
    
    (render_button brush_icon_tex 0 #f)
    (render_button brush_icon_tex 1 #f)
    (render_button brush_icon_tex 2 #f)
    (render_button brush_icon_tex 3 #f)
    (render_button brush_icon_tex 4 #f)
    (render_button brush_icon_tex 5 #f)
  )
)
