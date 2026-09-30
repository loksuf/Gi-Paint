(define-module
  (raylib) ; Module name
  #:use-module (system foreign)
)

(define bool uint8)

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

; DRAW =============

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

; RLAPI void ClearBackground(Color color);
(define-public clear_background
  (pointer->procedure
    void
    (dynamic-func "ClearBackground" raylib_so)
    (list uint32)
  )
)

; RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);
(define-public draw_circle
  (pointer->procedure
    void
    (dynamic-func "DrawCircle" raylib_so)
    (list int int float uint32)
  )
)

; MOUSE =============

; RLAPI bool IsMouseButtonDown(int button);
(define-public is_mouse_button_down
  (pointer->procedure
    bool
    (dynamic-func "IsMouseButtonDown" raylib_so)
    (list int)
  )
)

; RLAPI int GetMouseX(void);
(define-public get_mouse_x
  (pointer->procedure
    int
    (dynamic-func "GetMouseX" raylib_so)
    '()
  )
)

; RLAPI int GetMouseY(void);
(define-public get_mouse_y
  (pointer->procedure
    int
    (dynamic-func "GetMouseY" raylib_so)
    '()
  )
)

; Utils ====

(define-public
  (c_str str)
  (string->pointer str "UTF-8")
)

