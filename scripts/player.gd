extends CharacterBody2D


const SPEED = 5*1000
const GRAVITY = PI**2				# I am never serious
	
func _physics_process(delta):
	player_movement(delta)

var can_move = true

# feedback request!!
var stage = 0
func jump(timer) -> void:
	can_move = true
	timer.queue_free()
	
var running = false
var last_movement = false		# false - x; true - y

func player_movement(delta):
	if Input.is_key_pressed(KEY_SHIFT):
		running = true
	else:
		running = false
	if can_move:
		
		
		
		if Input.is_key_pressed(KEY_SPACE):   # poniżej są parametry tworzonego timera, który potem usuwamy 
			var timer := Timer.new()           # na koniec skoku
			timer.wait_time = 0.31 
			timer.one_shot = false                #wywołując te funkcje 
			timer.autostart = true # start timer when added to a scene 
			timer.connect("timeout", Callable(self, "jump").bind(timer))
			add_child(timer)
			can_move = false
			
		elif Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_S)|| Input.is_key_pressed(KEY_A)|| Input.is_key_pressed(KEY_D):
			var dy = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))  # zmiana w x = WCIŚNIĘTY W - WCIŚNIĘTY S (W = 1; S = -1; W+S=0)
			var dx = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)) # zmiana w y = WCIŚNIĘTY A - WCIŚNIĘTY D (A = 1; D = -1; A+D=0)
			if last_movement:
				dy *= int(dx==0)                                                              # brak zmiany w y jeśli nastąpiła zmiana w x, można zamienić `dy` z `dx` aby uzyskać odwrotny rezultat
			else:
				dx *= int(dy==0)
			last_movement = abs(dx) > abs(dy)
			velocity.x = dx * (SPEED * (1 + int(running) * 5)) * delta
			velocity.y = dy * (SPEED * (1 + int(running) * 5)) * delta
		else:
			velocity.x = 0
			velocity.y = 0
	else:
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
