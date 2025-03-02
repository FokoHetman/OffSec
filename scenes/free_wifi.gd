extends Node

var dialog_scene = preload("res://scenes/dialog.tscn")
var translations = Translations.new()
var language
# Called when the node enters the scene tree for the first time.
func _ready():
	language = get_parent().get_parent().global_data["language"]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func raw_connect():
	if dialog_scene.can_instantiate():
		var dialog = dialog_scene.instantiate()
		add_child(dialog)
		if get_parent().get_parent().global_data["progress"]==4:
			dialog.dialog([
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["tavern.text3"], load("res://art/portrait.png")],
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["tavern.text4"], load("res://art/portrait.png"),
					Callable(self, "inc")],
				], get_parent().get_parent().player)
		else:
			dialog.queue_free()
func inc():
	get_parent().get_parent().global_data["progress"]+=1
