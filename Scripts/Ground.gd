extends MeshInstance
class_name Ground

signal move_here(position)

var default_material : SpatialMaterial
var mouse_over_material : SpatialMaterial = load("res://Resources/Materials/GreenAlbedo.tres")
var mouse_over = false


func _process(delta):
	if mouse_over:
		set_surface_material(0, mouse_over_material)
	else:
		set_surface_material(0, default_material)


func _input(event):
	if event.is_action_pressed("move_here") and mouse_over:
		print("emmiting signal")
		emit_signal("move_here", translation)


func _on_Area_mouse_entered():
	mouse_over = true


func _on_Area_mouse_exited():
	mouse_over = false
