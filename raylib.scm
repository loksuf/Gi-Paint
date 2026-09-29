(define-module
  (raylib) ; Module name
  #:use-module (system foreign)
)

(define bool int)

(define raylib_so (dynamic-link "libraylib.so"))

; void InitWindow(int width, int height, const char *title)
(define-public init_window 
  (pointer->procedure
    void
    (dynamic-func "InitWindow" raylib_so)
    (list int int '*)
  )
)

; RLAPI bool WindowShouldClose(void); 
(define-public window_should_close 
  (pointer->procedure
    bool
    (dynamic-func "WindowShouldClose" raylib_so)
    '()
  )
)

; RLAPI void CloseWindow(void);
(define-public close_window
  (pointer->procedure
    void
    (dynamic-func "CloseWindow" raylib_so)
    '()
  )
)

; RLAPI void SetTargetFPS(int fps);
(define-public set_target_fps
  (pointer->procedure
    void
    (dynamic-func "SetTargetFPS" raylib_so)
    (list int)
  )
)

; RLAPI void BeginDrawing(void);
(define-public begin_drawing
  (pointer->procedure
    void
    (dynamic-func "BeginDrawing" raylib_so)
    '()
  )
)

; RLAPI void EndDrawing(void);  
(define-public end_drawing
  (pointer->procedure
    void
    (dynamic-func "EndDrawing" raylib_so)
    '()
  )
)

; Utils ====

(define-public
  (c_str str)
  (string->pointer str "UTF-8")
)

