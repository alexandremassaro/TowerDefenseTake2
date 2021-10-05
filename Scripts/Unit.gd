extends Path
class_name Unit


var move_speed = 5.5
var selected = false
var mouse_over = false

var selected_texture = load("res://Resources/Materials/GreenAlbedo.tres")
var deselected_texture = load("res://Resources/Materials/LightGrayAlbedo.tres")
var path : Curve3D
onready var path_follow = get_node("PathFollow")

func _ready():
#	path.add_point(Vector3(0,0,0))
#	path.add_point(Vector3(0,0,-30))
#	path.add_point(Vector3(30,0,-30))
#	path.add_point(Vector3(30,0,30))
#	path.add_point(Vector3(-30,0,30))
#	path.add_point(Vector3(-30,0,-30))
	deselect_unit()
	set_curve(path)
	var position : Vector3
	connect("move_here", self, "move_to", [ position ])
	#self.connect("move_here", self, "move_to")


func _process(delta):
	move(delta)


func _set_path_points(points : PoolVector3Array):
	path.clear_points()
	for point in points:
		path.add_point(point)
	
#	set_curve(path)
	


func move(delta):
	if path_follow.get_unit_offset() < 1.0:
		path_follow.set_offset(path_follow.get_offset() + move_speed * delta)


func move_to(position):
	if selected:
		
		if path_follow.get_unit_offset() < 1.0:
			path.remove_point(path.get_point_count() - 1)
			path.add_point(path_follow.translation)
		else: 
			path.clear_points()
			path.add_point(path_follow.translation)
			path_follow.set_offset(0.0)
		
		path.add_point(position)
		

func _input(event):
	if event.is_action_pressed("select_unit"):
		deselect_unit()
		if mouse_over:
			select_unit()


func select_unit():
	var mesh = get_node("PathFollow/Mesh")
	selected = true
	mesh.set_surface_material(0, selected_texture)


func deselect_unit():
	var mesh = get_node("PathFollow/Mesh")
	selected = false
	mesh.set_surface_material(0, deselected_texture)


func _on_Area_mouse_entered():
	mouse_over = true


func _on_Area_mouse_exited():
	mouse_over = false
