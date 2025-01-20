extends CharacterBody2D



const speed = 5000



func _physics_process(delta):
	player_movement(delta)
	
	
	
func player_movement(delta):



	if Input.is_action_pressed("ui_right"):
		velocity.x = speed*delta
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed*delta
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -speed*delta
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = speed*delta
	else:
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
