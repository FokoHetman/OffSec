extends Sprite2D

var language
var dialog_scene = preload("res://scenes/dialog.tscn")
var translations = Translations.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	language = get_parent().get_parent().global_data["language"]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func monitor(bol):
	if bol:
		if dialog_scene.can_instantiate():
			var dialog = dialog_scene.instantiate()
			add_child(dialog)
			if get_parent().get_parent().global_data["progress"]==5:
				dialog.dialog([
				[translations.translations[language]["helpful_spirit"], "...", load("res://art/portrait.png"),
					Callable(self, "inc")],
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["tavern.text5"], load("res://art/portrait.png")],
				], get_parent().get_parent().player)
			else:
				dialog.queue_free()

func inc():
	get_parent().get_parent().get_node("FSH/CanvasLayer/Output").text = "connection found:\nhttp://wizard.com/path?password=123\n from 192.168.0.2"
	get_parent().get_parent().global_data["progress"]+=1
