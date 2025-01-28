extends CharacterBody2D


const SPEED = 5*1000
const GRAVITY = PI**2				# I am never serious
	
func _physics_process(delta):
	player_movement(delta)

var can_move = false

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
	
var running = false
var last_movement = false		# false - x; true - y

func player_movement(delta):
	if !can_move:
		return
	if Input.is_key_pressed(KEY_SHIFT):
		running = true
	else:
		running = false
		
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
		elif Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_S)|| Input.is_key_pressed(KEY_A)|| Input.is_key_pressed(KEY_D):
			var dy = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))  # zmiana w x = WCIŚNIĘTY W - WCIŚNIĘTY S (W = 1; S = -1; W+S=0)
			var dx = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)) # zmiana w y = WCIŚNIĘTY A - WCIŚNIĘTY D (A = 1; D = -1; A+D=0)
			if last_movement:
				dy *= int(dx==0)                                                              # brak zmiany w y jeśli nastąpiła zmiana w x, można zamienić `dy` z `dx` aby uzyskać odwrotny rezultat
			else:
				dx *= int(dy==0)
			last_movement = abs(dx) > abs(dy)
			velocity.x = dx * (SPEED * (1 + int(running))) * delta
			velocity.y = dy * (SPEED * (1 + int(running))) * delta
		else:
			velocity.x = 0
			velocity.y = 0
	else:
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
