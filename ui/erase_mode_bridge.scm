(define-module
  (ui erase_mode_bridge) ; Module name
)

; This file is only needed to pass the erase_mode state to the toolbar. Yeah, it's cringe, but I've only got two hours left... (-‸-)

(define erase_mode #f)

(define-public
  (get_erase_mode)
  erase_mode
)

(define-public
  (set_erase_mode value)
  (set! erase_mode value)
)
