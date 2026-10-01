(define-module
  (ui canvas) ; Module name
)

(add-to-load-path (dirname (current-filename)))
(use-modules (primitives))
(use-modules (raylib))
(use-modules (consts))
(use-modules (colors))

; global canvas_render_texture
; typedef struct RenderTexture {
;     unsigned int id;
;     Texture2D texture;
;     Texture2D depth;
; } RenderTexture2D;
(define canvas_render_texture #f)



; Canvas loader
(define-public
  (canvas_load)
  (begin
    (set! canvas_render_texture
      (load_render_texture SCREEN_WIDTH SCREEN_HEIGHT)
    )
    (begin_texture_mode canvas_render_texture)
    (clear_background canvas_background)
    (end_texture_mode)
  )
)

; ===== CANVAS CONTROLS DATA

(define current_color (rgba_struct 255 0 0 255))
(define canvas_pos_x 0)
(define canvas_pos_y 0)
(define canvas_offset_x 0)
(define canvas_offset_y 0)
(define canvas_width SCREEN_WIDTH)
(define canvas_height SCREEN_HEIGHT)
(define drawing_tool_radius 10.0)

(define current_tool "brush")

; Set current_color
(define-public
  (set_current_color rgba)
  (set! current_color rgba)
)

; Get current_color
(define-public
  (get_current_color)
  current_color
)

; Change current_tool
(define-public
  (change_current_tool new_tool_name)
  (set! current_tool new_tool_name)
)

; Get current_tool
(define-public
  (get_current_tool)
  current_tool
)

; Area callback
(define-public
  (canvas_area_callback)
  (list
    (cons 
      canvas_pos_x
      canvas_pos_y
    )
    (cons
      (+ canvas_pos_x canvas_width)
      (+ canvas_pos_y canvas_height)
    )
  )
)

(define blocked_repeat_interact #f)
(define brush_tail #f)
(define mouse_prev_pos (list 0 0))

; Interact callbackget_mouse
(define-public
  (canvas_interact_callback hit_pos interaction_type interaction_data)
  (let*
    (
     (relative_hit_pos
       (cons 
         (- (+ (car hit_pos) ) canvas_pos_x)
         (- (cdr hit_pos) canvas_pos_y )
         )
       )
     (rel_hit_pos_x (car relative_hit_pos))
     (rel_hit_pos_y (cdr relative_hit_pos))
     )

    (if
      (string=? interaction_type "mouse")
      (let
        (
         (mouse_button_code (car interaction_data))
         )
        (cond
          (
           (= mouse_button_code MOUSE_BUTTON_LEFT)
           (cond
             (
              (string=? current_tool "stamp")
              (if
                (not blocked_repeat_interact)
                (let
                  (
                   
                   (blot (make_blot rel_hit_pos_x rel_hit_pos_y drawing_tool_radius current_color))
                   )
                  (canvas_draw_abstract "blot" blot)
                  (set! blocked_repeat_interact #t)

                  )
                )
              )
             (
              (string=? current_tool "brush")
              (if
                brush_tail
                (let
                  (
                   (blot (make_blot rel_hit_pos_x rel_hit_pos_y drawing_tool_radius current_color))
                   )
                  (canvas_draw_abstract "stroke" (cons blot brush_tail))
                  (set! brush_tail (cons (blot_get_x blot) (blot_get_y blot)) )

                  )
                
                (let
                  (
                   (blot (make_blot rel_hit_pos_x rel_hit_pos_y drawing_tool_radius current_color))
                   )
                  (canvas_draw_abstract "blot" blot)
                  (set! brush_tail (cons (blot_get_x blot) (blot_get_y blot)) )
                  )
                )
              )
             (
              (string=? current_tool "fill")
              (canvas_draw_abstract "fill" (cons rel_hit_pos_x rel_hit_pos_y ) )
              )
             )
           )
          (
            (= mouse_button_code MOUSE_BUTTON_MIDDLE)
            (begin
              (let
                (
                  (offset_x (- (car mouse_prev_pos) (get_mouse_x)))
                  (offset_y (- (cdr mouse_prev_pos) (get_mouse_y)))
                )
                (set! canvas_pos_x 
                  (- canvas_pos_x offset_x)
                )
                (set! canvas_pos_y
                  (- canvas_pos_y offset_y)
                )
                (set! canvas_offset_x (- canvas_offset_x offset_x))
                (set! canvas_offset_y (- canvas_offset_y offset_y))
                (set! mouse_prev_pos (cons (get_mouse_x) (get_mouse_y)) )
              )
              ; for return : use minus
            )
          )
          (
           (= mouse_button_code MOUSE_BUTTON_NONE)
           (begin
             (set! blocked_repeat_interact #f)
             (set! brush_tail #f)
             (set! mouse_prev_pos (cons (get_mouse_x) (get_mouse_y)) )
             )
           )
          )
        )
      )
    )
  )

; ===== CANVAS PRIMITIVES

; draw_blot_from_struct
(define
  ; args: blot_type
  (draw_blot_from_struct blot)
  (draw_circle (blot_get_x blot) (blot_get_y blot) (blot_get_radius blot) (blot_get_rgba blot) )
)

; draw_stroke_from_blot
(define
  ; args: blot_type vec2_pair(x,y)
  (draw_stroke_from_blot dest_blot tail_pos)
  (draw_line_ex
    (make_c_vector2 (car tail_pos) (cdr tail_pos))
    (make_c_vector2 (blot_get_x dest_blot) (blot_get_y dest_blot))
    (* (blot_get_radius dest_blot) 2)
    (blot_get_rgba dest_blot)
  )
)

; =====

(define reverse_queue '())

(define
  (list_push_front lst data)
  (set! reverse_queue (cons data lst))
)

(define-public
  (canvas_draw_abstract draw_type data)
  (list_push_front reverse_queue (cons draw_type data))
)

(define (fluid_fill_rec_ image x y color max_x max_y)
  (if
    (and
      (< y max_y)
      (>= y 0)
      (< x max_x)
      (>= x 0)
    )
    (let
      (
        (cur_pixel_color (get_image_color image x y))
      )
      (if
        (not (= cur_pixel_color color))
        (begin
          (image_draw_pixel image x y color)
          (fluid_fill_rec_ image (+ x 1) y color max_x max_y)
          (fluid_fill_rec_ image (- x 1) y color max_x max_y)
          (fluid_fill_rec_ image x (+ y 1) color max_x max_y)
          (fluid_fill_rec_ image x (- y 1) color max_x max_y)
        )
      )
    )
  )
)

(define
  (fluid_fill image x y color)
  (let
    (
      (image_size_vec2 (get_size_of_image image))
    )
    (fluid_fill_rec_ image x (- (cdr image_size_vec2) y) color (car image_size_vec2) (cdr image_size_vec2))
  )
)

(define (draw_all_in_queue)
  (if
    (not (null? reverse_queue))
    (begin
      (cond
        (
          (string=? (car (car reverse_queue)) "blot")
          (draw_blot_from_struct (cdr (car reverse_queue)))
        )
        (
          (string=? (car (car reverse_queue)) "stroke")
          (begin
            (draw_stroke_from_blot 
              (car (cdr (car reverse_queue)))
              (cdr (cdr (car reverse_queue)))
            )
            (draw_blot_from_struct
              (car (cdr (car reverse_queue)))
            )
          )
        )
        (
          (string=? (car (car reverse_queue)) "fill")
          (let
            (
              (image 
                (load_image_from_texture 
                  (get_canvas_texture canvas_render_texture)
                )
              )
              (pixel_x
                (car (cdr (car reverse_queue)))
              )
              (pixel_y
                (cdr (cdr (car reverse_queue)))
              )
            )
            (let
              (
                (color
                  (get_image_color image pixel_x pixel_y)
                )
              )
              (if
                (not (= color current_color))
                (begin
                  (fluid_fill image pixel_x pixel_y current_color)
                  (update_texture (get_canvas_texture canvas_render_texture) (get_image_data_ptr image))
                )
              )
            )
          )
        )
      )
      (set! reverse_queue (cdr reverse_queue))
      (draw_all_in_queue)
    )
  )
)

; Canvas render
(define-public
  (canvas_render erase_mode)
  (begin
    
    ; Focus to drawing in canvas_texture
    (begin_texture_mode canvas_render_texture)
    (if erase_mode
      (begin_blend_mode ERASE_BLEND_MODE)
    )
    (draw_all_in_queue)
    (if erase_mode
      (end_blend_mode)
    )
    (end_texture_mode)

    (draw_texture_pro
      (get_canvas_texture canvas_render_texture)
      (make_c_rectangle 0 0 canvas_width (- canvas_height))
      (make_c_rectangle canvas_pos_x canvas_pos_y canvas_width canvas_height)
      (make_c_vector2 0 0)
      0.0
      (rgba_struct 255 255 255 255)
    )
  )
)
