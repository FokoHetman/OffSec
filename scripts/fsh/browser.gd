extends Node

var icon = preload("res://art/browser.png")

func show_browser():
	var browser = Sprite2D.new()
	browser.texture = icon
	browser.position = Vector2((randi() % get_viewport().size.x), (randi() % get_viewport().size.y))
	add_child(browser)
