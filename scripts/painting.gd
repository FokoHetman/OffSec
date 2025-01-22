extends Area2D

var result_height = 160
var fallen = false
var falling = false
var stage
func _mouse_enter():
	if not fallen && not falling:
		falling = true
		stage = 0
		var timer := Timer.new()
		timer.wait_time = 0.01 # 1 second
		timer.one_shot = false
		timer.autostart = true # start timer when added to a scene
		timer.connect("timeout", Callable(self, "fall").bind(timer))
		add_child(timer)

func fall(timer):
	if stage>15:
		timer.queue_free()
	else:
		get_parent().position.y+=3
	stage += 1

