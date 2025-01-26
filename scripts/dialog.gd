extends Node2D

var delay = 0.1
var cursor = 0
var text = ""


func write(message: String):
	cursor = 0
	text = ""
	var timer := Timer.new()
	timer.wait_time = delay
	timer.one_shot = false
	timer.autostart = true # start timer when added to a scene
	timer.connect("timeout", Callable(self, "write_char").bind(message, timer))
	add_child(timer)

func write_char(message: String, timer):
	if cursor>=len(message):
		timer.queue_free()
	else:
		text += message[cursor]
		$CanvasLayer/Title.text = text
		cursor+=1
		# I'll record my keyboard and insert a sound here, will be fun right?

func _ready():
	write("hello there!!!!!!!!!!")
