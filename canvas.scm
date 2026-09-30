(define-module
  (canvas) ; Module name
)

(add-to-load-path (dirname (current-filename)))
(use-modules (primitives))
(use-modules (raylib))
(use-modules (consts))

; global canvas_texture
; typedef struct RenderTexture {
;     unsigned int id;
;     Texture2D texture;
;     Texture2D depth;
; } RenderTexture2D;
(define canvas_texture #f)

; Canvas loader
(define-public
  (canvas_load)
  (begin
    (set! canvas_texture
      (load_render_texture SCREEN_WIDTH SCREEN_HEIGHT)
    )
  )
)
