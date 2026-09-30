(define-module
  (canvas) ; Module name
)

(add-to-load-path (dirname (current-filename)))
(use-modules (primitives))
(use-modules (raylib))
(use-modules (consts))
(use-modules (colors))

; global canvas_render_texture
; typedef struct RenderTexture {
;     unsigned int id;
;     Texture2D texture;
;     Texture2D depth;
; } RenderTexture2D;
(define canvas_render_texture #f)

; Canvas loader
(define-public
  (canvas_load)
  (begin
    (set! canvas_render_texture
      (load_render_texture SCREEN_WIDTH SCREEN_HEIGHT)
    )
    (begin_texture_mode canvas_render_texture)
    (clear_background canvas_background)
    (end_texture_mode)
  )
)

; Canvas render
(define-public
  (canvas_render)
  (begin
    (draw_texture_pro
      (get_canvas_texture canvas_render_texture)
      (make_c_rectangle 0 0 200 200)
      (make_c_rectangle 0 0 200 200)
      (make_c_vector2 0 0)
      0.0
      canvas_background
    )
  )
)
