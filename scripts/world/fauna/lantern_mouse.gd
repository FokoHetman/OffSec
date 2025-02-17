extends Node2D

const max_string_len = 100

enum SPRITE_DIRECTION {
	DOWN,
	LEFT, # no impl vvv
	RIGHT,
	UP
}


enum AI_GOALS {
	Hang,
	Escape,
	LookForRoof,
}
var goal

var attachment_point: Vector2

'''var colors = [
	Color(1, 168.0/255.0, 164.0/255.0, 1),
	Color(1, 229.0/255.0, 204.0/255.0, 1),
	Color(204.0/255.0, 216.0/255.0, 1, 1),
] gonna leave it cuz it's bunch of cool colors'''

func _ready():
	goal = AI_GOALS.Hang
	attachment_point = Vector2(61,18)
	#$poly_down.modulate = colors.pick_random()
	$poly_down.modulate = Color(max(0.8, min(1.0, randf()+0.4)),max(0.8, min(1.0, randf()+0.4)),max(0.8, min(1.0, randf()+0.4)))

func sprite(state):
	match state:
		SPRITE_DIRECTION.DOWN:
			$poly_down.visible = true

func hang():
	sprite(SPRITE_DIRECTION.DOWN)
	$skeleton_down/tail.position = lerp($skeleton_down/tail.position, attachment_point+Vector2(0, max_string_len), 0.1) 
	if tick>35:
		wind()
	if tick%2==0:
		gravity()

var inertia = 0
var base_inertia = 0
func wind():
	var wind_val = $Weather.get_wind_at(get_parent().name, $skeleton_down/tail/body/head.position)
	$skeleton_down/tail.position = lerp($skeleton_down/tail.position, $skeleton_down/tail.position+wind_val, 0.1)
	inertia += wind_val.x * 0.1
	base_inertia += wind_val.x * 0.1

func gravity():
	$skeleton_down/tail.position.x = lerp($skeleton_down/tail.position.x, $skeleton_down/tail.position.x-inertia*2.3, 0.1)
	inertia -= 0.1*base_inertia
	if sign(inertia)!=sign(base_inertia):
		base_inertia = 0
		inertia = 0
	if inertia==0 && base_inertia==0:
		$skeleton_down/tail.position.x = lerp($skeleton_down/tail.position.x, attachment_point.x, 0.4)
	
	# $skeleton_down/tail.position
	# attachment_point
	var dy = abs($skeleton_down/tail.position.y - attachment_point.y)
	var dx = abs($skeleton_down/tail.position.x - attachment_point.x)
	print(dx, dy, atan(dy/dx)- deg_to_rad(90))
	$skeleton_down/tail.rotation = atan(dy/dx)- deg_to_rad(90)
	
var tick = 0
func _process(d):
	if tick>80:
		tick = 0
	if tick%2==0:
		match goal:
			AI_GOALS.Hang:
				hang()
			_:
				pass
	tick += 1
