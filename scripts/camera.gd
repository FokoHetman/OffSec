extends Camera2D

var deadzone = Vector2(15,10)

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().player:
		var d_pos = offset - get_parent().player.position
		if abs(d_pos.x)>deadzone.x:
			offset = lerp(offset, get_parent().player.position, 0.1)
		if abs(d_pos.y)>deadzone.y:
			offset = lerp(offset, get_parent().player.position, 0.1)
