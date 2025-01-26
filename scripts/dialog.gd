extends Node2D

var delay = 0.1
var cursor = 0
var text = ""




func _ready():
	$CanvasLayer/Title.add_theme_font_size_override("font_size", 20)
	#write("Jan Kowalski", "hello there!!!!!!!!!!")
	$CanvasLayer/Ok.connect("button_up", Callable(self, "next"))

var  data = []
func dialog(p_data):
	data = p_data
	next()

func next():
	if len(data)>0:
		write(data[0][0], data[0][1])
		$CanvasLayer/Portrait.texture = data[0][2]
		data.remove_at(0)
	else:
		queue_free()


func write(title: String, message: String):
	cursor = 0
	text = ""
	$CanvasLayer/Title.text = title
	var timer := Timer.new()
	$CanvasLayer/Ok.visible = false
	timer.wait_time = delay
	timer.one_shot = false
	timer.autostart = true # start timer when added to a scene
	timer.connect("timeout", Callable(self, "write_char").bind(message, timer))
	add_child(timer)

func write_char(message: String, timer):
	if cursor>=len(message):
		$CanvasLayer/Ok.visible = true
		timer.queue_free()
	else:
		text += message[cursor]
		$CanvasLayer/Text.text = text
		cursor+=1
		# I'll record my keyboard and insert a sound here, will be fun right?
