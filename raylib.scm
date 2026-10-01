(define-module
  (raylib) ; Module name
  #:use-module (system foreign)
  #:use-module (rnrs bytevectors)
)

(define bool uint8)

(define raylib_so (dynamic-link "libraylib.so"))

; STRUCTS

(define c_color uint32)
(define c_vector2 (list float float))
(define c_rectangle (list float float float float))
(define c_texture2d (list uint32 int int int int))
(define c_render_texture2d (list uint32 c_texture2d c_texture2d))
; typedef struct Image {
;     void *data;             // Image raw data
;     int width;              // Image base width
;     int height;             // Image base height
;     int mipmaps;            // Mipmap levels, 1 by default
;     int format;             // Data format (PixelFormat type)
; } Image;
(define c_image (list '* int int int int))

; FACTORY FUNCTIONS For C Structs

; Make c_vector2
(define-public
  (make_c_vector2 x y)
  (make-c-struct c_vector2
    (list
      (exact->inexact x)
      (exact->inexact y)
    )
  )
)
; Make c_rectangle
(define-public
  (make_c_rectangle x y width height)
  (make-c-struct c_rectangle
    (list
      (exact->inexact x)
      (exact->inexact y)
      (exact->inexact width)
      (exact->inexact height)
    )
  )
)
; Make c_texture2d
(define-public
  (make_c_texture2d id width height mipmaps format)
  (make-c-struct c_texture2d
    (list
      id 
      width 
      height 
      mipmaps 
      format
    )
  )
)

; Make c_image
(define-public
  (make_c_image data_ptr width height mipmaps format)
  (make-c-struct c_image
    (list
      data_ptr
      width
      height 
      mipmaps
      format
    )
  )
)

; Utils ====

(define-public
  (c_str str)
  (string->pointer str "UTF-8")
)

; FUNCTIONS ================

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

; RLAPI void DrawRectangle(int posX, int posY, int width, int height, Color color);
(define-public draw_rectangle
  (pointer->procedure
    void
    (dynamic-func "DrawRectangle" raylib_so)
    (list int int int int c_color)
  )
)

; RLAPI void BeginBlendMode(int mode);
(define-public begin_blend_mode
  (pointer->procedure
    void
    (dynamic-func "BeginBlendMode" raylib_so)
    (list int)
  )
)

; RLAPI void EndBlendMode(void);
(define-public end_blend_mode
  (pointer->procedure
    void
    (dynamic-func "EndBlendMode" raylib_so)
    '()
  )
)

; RLAPI void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);
(define-public draw_line_ex
  (pointer->procedure
    void
    (dynamic-func "DrawLineEx" raylib_so)
    (list c_vector2 c_vector2 float c_color)
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

; RLAPI void ClearBackground(Color color);
(define-public clear_background
  (pointer->procedure
    void
    (dynamic-func "ClearBackground" raylib_so)
    (list c_color)
  )
)

; RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);
(define-public draw_circle
  (pointer->procedure
    void
    (dynamic-func "DrawCircle" raylib_so)
    (list int int float c_color)
  )
)

; CONTROLS =============

; Mouse

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

; Keyboard

;RLAPI bool IsKeyPressed(int key);
(define-public is_key_pressed
  (pointer->procedure
    bool
    (dynamic-func "IsKeyPressed" raylib_so)
    (list int) ; (check KeyboardKey in raylib.h)
  )
)

;RLAPI bool IsKeyReleased(int key);
(define-public is_key_released
  (pointer->procedure
    bool
    (dynamic-func "IsKeyReleased" raylib_so)
    (list int) ; (check KeyboardKey in raylib.h)
  )
)

; TEXTURE ============

; RLAPI Texture2D LoadTexture(const char *fileName);
(define-public load_texture
  (pointer->procedure
    c_render_texture2d
    (dynamic-func "LoadTexture" raylib_so)
    (list '*)
  )
)

; RLAPI RenderTexture2D LoadRenderTexture(int width, int height); 
(define-public load_render_texture
  (pointer->procedure
    c_render_texture2d
    (dynamic-func "LoadRenderTexture" raylib_so)
    (list int int)
  )
)

; RLAPI void BeginTextureMode(RenderTexture2D target);
(define-public begin_texture_mode
  (pointer->procedure
    void
    (dynamic-func "BeginTextureMode" raylib_so)
    (list c_render_texture2d)
  )
)

; RLAPI void EndTextureMode(void);
(define-public end_texture_mode
  (pointer->procedure
    void
    (dynamic-func "EndTextureMode" raylib_so)
    '()
  )
)

; RLAPI void DrawTexturePro(Texture2D texture, Rectangle srcrec, Rectangle dstrec, Vector2 origin, float rotation, Color tint);
(define-public draw_texture_pro
  (pointer->procedure
    void
    (dynamic-func "DrawTexturePro" raylib_so)
    (list c_texture2d c_rectangle c_rectangle c_vector2 float c_color)
  )
)

; RLAPI void UpdateTexture(Texture2D texture, const void *pixels);
(define-public update_texture
  (pointer->procedure
    void
    (dynamic-func "UpdateTexture" raylib_so)
    (list c_texture2d '*)
  )
)

(define-public 
  (load_texture_from_file filepath)
  (load_texture (c_str filepath))
)

(define-public
  (get_canvas_texture canvas_render_texture)
  (make-c-struct
    c_texture2d
    (cadr 
      (parse-c-struct canvas_render_texture c_render_texture2d)
    )
  )
)

; IMAGE ========

; RLAPI Image LoadImageFromTexture(Texture2D texture);
(define-public load_image_from_texture
  (pointer->procedure
    c_image
    (dynamic-func "LoadImageFromTexture" raylib_so)
    (list c_texture2d)
  )
)

; RLAPI Color GetImageColor(Image image, int x, int y);
(define-public get_image_color
  (pointer->procedure
    c_color
    (dynamic-func "GetImageColor" raylib_so)
    (list c_image int int)
  )
)

; RLAPI void ImageDrawPixel(Image *dst, int posX, int posY, Color color);
(define-public image_draw_pixel
  (pointer->procedure
    void
    (dynamic-func "ImageDrawPixel" raylib_so)
    (list '* int int c_color)
  )
)

; get_image_data_ptr
(define-public 
  (get_image_data_ptr image)
  (car (parse-c-struct image c_image))
)

; get_size_of_image
(define-public 
  (get_size_of_image image)
  (let* 
    (
      (parsed_struct
        (parse-c-struct image c_image)
      )
      (width (cadr parsed_struct))
      (height (caddr parsed_struct))
    )
    (cons width height)
  )
)

