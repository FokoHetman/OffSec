extends Node2D

var dialog_scene = preload("res://scenes/dialog.tscn")
var translations = Translations.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().player.position = Vector2(100,150)
	var language = get_parent().global_data["language"]
	if dialog_scene.can_instantiate():
		var dialog = dialog_scene.instantiate()
		add_child(dialog)
		if get_parent().global_data["progress"]==3:
			dialog.dialog([
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["tavern.text1"], load("res://art/portrait.png")],
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["tavern.text2"], load("res://art/portrait.png"),
					Callable(self, "inc")],
				], get_parent().player)
		else:
			dialog.queue_free()

func inc():
	get_parent().global_data["progress"]+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
