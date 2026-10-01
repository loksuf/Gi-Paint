(define-module
  (colors) ; Module name
)

; Utils

; RGBA to C struct
(define-public
  (rgba_struct r g b a)
    (
      + 
      r
      (* g 256)
      (* b 65536)
      (* a 16777216)
    )
)

; CONSTS

(define-public canvas_background (rgba_struct 131 111 125 255))

; Theme

(define-public theme_background (rgba_struct 68 67 68 255))
(define-public THEME_TOOLBAR_BG (rgba_struct 58 58 58 255))
(define-public THEME_SHADOW (rgba_struct 63 63 63 255))
(define-public THEME_SEL_ICON_BG (rgba_struct 100 100 100 255))
(define-public THEME_ICON_BG (rgba_struct 70 70 70 255))

