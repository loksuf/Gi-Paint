#!/usr/bin/env -S guile
!#

(use-modules (system foreign))

(define raylib (dynamic-link "libraylib.so"))

(define bool int)

; void InitWindow(int width, int height, const char *title)
(define init_window 
  (pointer->procedure
    void
    (dynamic-func "InitWindow" raylib)
    (list int int '*)
  )
)

; RLAPI bool WindowShouldClose(void); 
(define window_should_close 
  (pointer->procedure
    bool
    (dynamic-func "WindowShouldClose" raylib)
    '()
  )
)

; RLAPI void CloseWindow(void);
(define close_window
  (pointer->procedure
    void
    (dynamic-func "CloseWindow" raylib)
    '()
  )
)

; RLAPI void SetTargetFPS(int fps);
(define set_target_fps
  (pointer->procedure
    void
    (dynamic-func "SetTargetFPS" raylib)
    (list int)
  )
)

; RLAPI void BeginDrawing(void);
(define begin_drawing
  (pointer->procedure
    void
    (dynamic-func "BeginDrawing" raylib)
    '()
  )
)

; RLAPI void EndDrawing(void);  
(define end_drawing
  (pointer->procedure
    void
    (dynamic-func "EndDrawing" raylib)
    '()
  )
)

; - CONSTS

(define fps 60)
(define screen_width 800)
(define screen_height 700)

; - FUNCS

; On close
(define (on_close)
  (begin
    (display "Closing the process...")
    (newline)
    (close_window)
    (display "Exited!")
    (newline)
  )
)

; Render frame
(define (render_frame)
    ; Body
  (begin
    (begin_drawing)
    (end_drawing)
  )
)

; Render loop
(define (start_render_loop)
  (if (= (window_should_close) 0)
    (begin
      (render_frame)
      (start_render_loop)
    )
    (on_close)
 )
)

; ENTRY
(define (main)
  (begin
    (init_window screen_width screen_height (string->pointer "PAINT"))
    (set_target_fps fps)
    (start_render_loop)
  )
)

(main)
