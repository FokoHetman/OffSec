extends Node2D


func get_wind_at(world, position):
	return Vector2(50,0)#return Vector2((abs(position.x)+abs(position.y))/10, 0) # this code is so ass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
