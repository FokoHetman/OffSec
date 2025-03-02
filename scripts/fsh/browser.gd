extends Node

var icon = preload("res://art/browser.png")

func show_browser():
	var browser = Sprite2D.new()
	browser.texture = icon
	browser.position = Vector2((get_viewport().size.x - icon.get_size().x)/2, (get_viewport().size.y - icon.get_size().x)/2)
	add_child(browser)
