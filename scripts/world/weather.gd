extends Node2D


var wind_texture = preload("res://art/wind.png")

func get_wind_at(world, position):
	return Vector2(50,0)#return Vector2((abs(position.x)+abs(position.y))/10, 0) # this code is so ass


var iteration = 0
func wind_object_movement(timer, poly):
	if iteration>=100:
		iteration = 0
		poly.queue_free()
		timer.queue_free()
	iteration += 1
	poly.position = lerp(poly.position, poly.position + 2*get_wind_at(get_parent().name, poly.position), 0.05)

func spawn_wind_object(at: Vector2):
	var poly = Sprite2D.new()
	poly.texture = wind_texture
	poly.position = at
	add_child(poly)
	var timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 0.01
	timer.autostart = true
	timer.connect("timeout", Callable(self, "wind_object_movement").bind(timer, poly))
	add_child(timer)
	return poly

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
