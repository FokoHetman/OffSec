extends CharacterBody2D


const SPEED = 5*1000
const GRAVITY = PI**2				# I am never serious
	
func _physics_process(delta):
	player_movement(delta)


# feedback request!!
var jumping = false
var stage = 0
func jump(timer) -> void:
	if stage>40:
		jumping = false
		timer.queue_free()
		$CollisionShape2D.set_deferred("disabled",false)
	elif stage>20:
		velocity.y += GRAVITY*10
	else:
		velocity.y -= GRAVITY*10
	stage += 1
	move_and_slide()
	print(stage)
	

func player_movement(delta):
	
	if not jumping:
		if Input.is_key_pressed(KEY_SPACE):
			stage = 0
			var timer := Timer.new()
			timer.wait_time = 0.01 # 1 second
			timer.one_shot = false
			timer.autostart = true # start timer when added to a scene
			timer.connect("timeout", Callable(self, "jump").bind(timer))
			add_child(timer)
			$CollisionShape2D.set_deferred("disabled",true)
			jumping = true
		elif Input.is_action_pressed("ui_right"):
			velocity.x = SPEED*delta
			velocity.y = 0
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED*delta
			velocity.y = 0
		elif Input.is_action_pressed("ui_up"):
			velocity.x = 0
			velocity.y = -SPEED*delta
		elif Input.is_action_pressed("ui_down"):
			velocity.x = 0
			velocity.y = SPEED*delta
		else:
			velocity.x = 0
			velocity.y = 0
	else:
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
