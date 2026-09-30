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

; Theme

(define-public theme_background (rgba_struct 46 44 45 255))
