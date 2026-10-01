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
(define-public THEME_SEL_ICON_BG (rgba_struct 180 180 180 255))
(define-public THEME_ICON_BG (rgba_struct 70 70 70 255))

(define-public COLOR_BUTTON_BG_RED (rgba_struct 131 111 125 255))

(define-public COLOR_BUTTON_RED (rgba_struct 255 0 0 255))
(define-public COLOR_BUTTON_PINK (rgba_struct 255 0 245 255))
(define-public COLOR_BUTTON_PURPLE (rgba_struct 124 0 255 255))
(define-public COLOR_BUTTON_BLUE (rgba_struct 0 3 255 255))
(define-public COLOR_BUTTON_CYAN (rgba_struct 0 255 255 255))
(define-public COLOR_BUTTON_GREEN (rgba_struct 0 255 33 255))
(define-public COLOR_BUTTON_YELLOW (rgba_struct 242 255 0 255))
(define-public COLOR_BUTTON_ORANGE (rgba_struct 255 107 0 255))
(define-public COLOR_BUTTON_WHITE (rgba_struct 255 255 255 255))
(define-public COLOR_BUTTON_GREY (rgba_struct 128 128 128 255))
(define-public COLOR_BUTTON_BLACK (rgba_struct 0 0 0 255))

