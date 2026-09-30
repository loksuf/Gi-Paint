(define-module
  (canvas) ; Module name
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
      )
      (set! reverse_queue (cdr reverse_queue))
      (draw_all_in_queue)
    )
  )
)

; Canvas render
(define-public
  (canvas_render)
  (begin
    (begin_texture_mode canvas_render_texture)
    (draw_all_in_queue)
    (draw_line_ex
      (make_c_vector2 0 0)
      (make_c_vector2 50 100)
      (* 15.8 2)
      (rgba_struct 255 0 0 255)
    )
    (end_texture_mode)

    (draw_texture_pro
      (get_canvas_texture canvas_render_texture)
      (make_c_rectangle 0 0 SCREEN_WIDTH (- SCREEN_HEIGHT))
      (make_c_rectangle 0 0 SCREEN_WIDTH SCREEN_HEIGHT)
      (make_c_vector2 0 0)
      0.0
      canvas_background
    )
  )
)
