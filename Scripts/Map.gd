extends Spatial
class_name Map

export var map_size = Vector2(37, 37)

onready var ground_mesh : MeshInstance = get_node("Ground")

export (PackedScene) var unit_scene = preload("res://Scenes/Units/Unit.tscn")
export (PackedScene) var ground_scene = preload("res://Scenes/SupportScenes/Ground.tscn")

export (SpatialMaterial) var red_material = preload("res://Resources/Materials/RedAlbedo.tres")
export (SpatialMaterial) var light_gray_material = preload("res://Resources/Materials/LightGrayAlbedo.tres")


func _ready():
	var unit1 : Path = unit_scene.instance()
	var path1 : Curve3D = Curve3D.new()
	path1.add_point(Vector3(0,0,10))
	path1.add_point(Vector3(37,0,10))	
	unit1.path = path1
	add_child(unit1)

	var unit2 : Path = unit_scene.instance()
	var path2 : Curve3D = Curve3D.new()
	path2.add_point(Vector3(0,0,20))
	path2.add_point(Vector3(19,0,20))	
	unit2.path = path2
	add_child(unit2)
	
	set_ground_size()


func set_ground_size():
	for x in range(map_size.x):
		for y in range(map_size.y):
			var tile = ground_scene.instance()
			var tile_size : Vector3 = tile.get_mesh().size
			tile.set_translation(Vector3(x * tile_size.x, - tile_size.y/2, y * tile_size.z))
			
			choose_tile_material(tile, Vector2(x, y))
			
			for unit in get_tree().get_nodes_in_group("units"):
				tile.connect("move_here", unit, "move_to")
					
			add_child(tile)


func choose_tile_material(tile, tile_position):
	if int(tile_position.x) % 2:
		if int(tile_position.y) % 2:
			tile.default_material = red_material
		else:
			tile.default_material = light_gray_material
	else:
		if int(tile_position.y) % 2:
			tile.default_material = light_gray_material
		else:
			tile.default_material = red_material
