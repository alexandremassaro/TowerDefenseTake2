extends Spatial
class_name camera

onready var screen_size = get_viewport().size
onready var mouse_pos = get_viewport().get_mouse_position()
onready var camera_tween = get_node("CameraTween")

var speed = 100.0

func _process(delta):
	move_camera(delta)


func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
	if event is InputEventMouseButton:
		if event.button_index == 4:
			zoom_in()
		elif event.button_index == 5:
			zoom_out()

func move_camera(delta):
	var position_ratio = (screen_size - mouse_pos) / screen_size
	var camera_position = translation
	var velocity : Vector3
	if (position_ratio.x > .9):
		velocity += Vector3(-1, 0, 0)
	if (position_ratio.x < .1):
		velocity += Vector3(1, 0, 0)
	if (position_ratio.y > .9):
		velocity += Vector3(0, 0, -1)
	if (position_ratio.y < .1):
		velocity += Vector3(0, 0, 1)
	
	velocity = velocity.normalized() * 5.0
	
	var new_position = camera_position + velocity
	
	camera_tween.interpolate_property(self, "translation", camera_position, new_position, speed * delta, Tween.TRANS_SINE, Tween.EASE_OUT)
	camera_tween.start()


func zoom_in():
	zoom(Vector3(0, -5, 0))

func zoom_out():
	zoom(Vector3(0, 5, 0))


func zoom(zoom_value : Vector3):
	var camera_obj = get_node("CameraObj")
	var camera_obj_tween = get_node("CameraObj/CameraObjTween")
	var cam_pos = camera_obj.translation
	var new_cam_pos = cam_pos + zoom_value
	
	camera_tween.interpolate_property(camera_obj, "translation", cam_pos, new_cam_pos, speed * .003, Tween.TRANS_SINE, Tween.EASE_OUT)
	camera_tween.start()
