extends Node


var map_scene = preload("res://Scenes/Maps/Map.tscn")
func _ready():
	var map  = map_scene.instance()
	add_child(map)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
