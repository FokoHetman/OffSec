extends Node2D

var resolution = [Vector2(640,340),Vector2(1600,900),Vector2(1920,1080)]

func _ready() -> void:
	back_to_main()
	for i in resolution:
		$CanvasLayer/Settings/resolution.add_item(str(i.x) +' x ' + str(i.y))

func back_to_main():
	$CanvasLayer/Settings.hide()
	$CanvasLayer/Main.show()


# >>> MAIN <<<
func _on_return_pressed() -> void:
	$CanvasLayer.hide()

func _on_save_pressed() -> void:
	get_parent().save_game() 

func _on_settings_pressed() -> void:
	$CanvasLayer/Settings.show()
	$CanvasLayer/Main.hide()

func _on_quit_pressed() -> void:
	get_tree().quit()


# >>> SETTINGS <<<
func settings_return() -> void:
	back_to_main()

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().mode = Window.MODE_FULLSCREEN
		$CanvasLayer/Settings/resolution.disabled = true
	else:
		get_window().mode = Window.MODE_WINDOWED
		$CanvasLayer/Settings/resolution.disabled = false

func _on_resolution_item_selected(index: int) -> void:
	get_window().size = resolution[index]
	get_window().position = Vector2((DisplayServer.screen_get_size().x-resolution[index].x)/2,(DisplayServer.screen_get_size().y-resolution[index].y)/2)
