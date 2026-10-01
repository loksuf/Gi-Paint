(define-module
  (ui ui_core) ; Module name
)

(define panels_ui_collisions '())

(define
  (puc_push_front data)
  (set! panels_ui_collisions (cons data panels_ui_collisions))
)

; rect_callback == 
; (func)
;         left top and right bottom corners
;   (list (x y) (x y)) 
;     or
;   (list (x y) (x y) (x y) (x y)) ; all of corners (in future...)
;
; interaction_callback ==
; (func) (hit_position_x_y_vec2_cons interaction_type interaction_data)
(define-public 
  (panels_ui_add_collider name area_callback interaction_callback)
  (puc_push_front (list name area_callback interaction_callback))
)

(define 
  (check_collision from_pos_vec2 area) ; four corners in future...
  (let*
    (
      (x (car from_pos_vec2))
      (y (cdr from_pos_vec2))
      (corner0_vec2 (car area))
      (corner3_vec2 (cadr area))
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

; find_collider_by_name
(define-public
  (find_collider_by_name collisions_list target_name)
  (if
    (null? collisions_list)
    #f
    (let*
      (
        (collider (car collisions_list))
        (collider_name (car collider))
      )
      (if
        (string=? collider_name target_name)
        collider
        (find_collider_by_name (cdr collisions_list) target_name)
      )
    )
  )
)

(define-public
  (panels_ui_ghost_interact panel_name interaction_type interaction_data)
  (let
    (
      (collider (find_collider_by_name panels_ui_collisions panel_name))
    )
    (if
      collider
      (begin
        ((caddr collider) (cons -1 -1) interaction_type interaction_data)
        #t
      )
      #f
    )
  )
)
