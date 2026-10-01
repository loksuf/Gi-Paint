(define-module
  (consts) ; Module name
)

(define-public APP_NAME "Gi-Paint")

; - CONSTS

(define-public FPS 60)
(define-public SCREEN_WIDTH 800)
(define-public SCREEN_HEIGHT 700)
(define-public TOOLBAR_WIDTH 40)

; Mouse input

(define-public MOUSE_BUTTON_NONE -1)
(define-public MOUSE_BUTTON_LEFT 0)
(define-public MOUSE_BUTTON_RIGHT 1)
(define-public MOUSE_BUTTON_MIDDLE 2)

; Keycodes (check KeyboardKey in raylib.h)

(define-public KEY_B 66)
(define-public KEY_E 69)
(define-public KEY_F 70)
(define-public KEY_S 83)

; Blend mode

(define-public ERASE_BLEND_MODE 6)

; Paths

(define-public BASE_DIR (dirname (current-filename)))
(define-public ICON_BRUSH_PATH (string-append BASE_DIR "/res/brush.png"))
(define-public ICON_STAMP_PATH (string-append BASE_DIR "/res/stamp.png"))
(define-public ICON_FILL_PATH (string-append BASE_DIR "/res/fill.png"))
(define-public ICON_ERASE_MODE_PATH (string-append BASE_DIR "/res/erase_mode.png"))

