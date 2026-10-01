(define-module
  (ui ui_core) ; Module name
)

(define panels_ui_collisions '())

(define
  (puc_push_front lst data)
  (set! panels_ui_collisions (cons data lst))
)

; rect_callback == 
; (func)
;         left top and right bottom corners
;   (list (x y) (x y)) 
;     or
;   (list (x y) (x y) (x y) (x y)) ; all of corners (in future...)
;
; interaction_callback ==
; (func) (hit_position_x_y_vec2_cons interaction_type data)
(define-public 
  (ui_add_collider name rect_callback interaction_callback)
  (list_push_front (list name rect_callback interaction_callback))
)

(define 
  (check_collision from_pos_vec2 area) ; four corners in future...
  (let*
    (
      (x (car from_pos_vec2))
      (y (cdr from_pos_vec2))
      (corner0_vec2 (car area))
      (corner3_vec2 (cdr area))
      (x1 (car corner0_vec2))
      (y1 (cdr corner0_vec2))
      (x3 (car corner3_vec2))
      (y3 (cdr corner3_vec2))
    )
    (if
      (and
        (>= x x1)
        (<= x x3)
        (>= y y1)
        (<= y y3)
      )
      #t
      #f
    )
  )
) 

(define-public
  (ui_interact from_pos_vec2 interaction_type interaction_data collisions_list)
  (if
    (null? collisions_list)
    #f
    (let*
      (
        (collider (car collisions_list))
        (collider_area ((cadr collider))) ; corners
        (collider_interact_callback (caddr collider))
        (is_collided 
          (check_collision from_pos_vec2 collider_area)
        )
      )
      (if
        is_collided
        (begin
          (collider_interact_callback from_pos_vec2 interaction_type interaction_data)
          #t
        )
        (ui_interact from_pos_vec2 interaction_type interaction_data (cdr collisions_list))
      )
    )
  )
)

; interaction_type : interaction_data
; "mouse" : mouse_button_code
; "keyboard" : keyboard_keycode
(define-public
  (panels_ui_interact from_pos_vec2 interaction_type interaction_data)
  (ui_interact from_pos_vec2 interaction_type interaction_data panels_ui_collisions)
)
