extends TileMap
class_name ObjectsTilemap

export(Dictionary) var TILE_SCENE := {
}

onready var half_size_cell := cell_size * 0.5

func _ready():
	yield(get_tree(), "idle_frame")
	_replace_tiles_with_scenes()

func _replace_tiles_with_scenes(scene_dictionary: Dictionary = TILE_SCENE):
	print(get_used_cells())
	for tile_pos in get_used_cells():
		print(tile_pos)
		var tile_id = get_cell(tile_pos.x, tile_pos.y)
		if scene_dictionary.has(tile_id):
			var object_scene = scene_dictionary[tile_id]
			_replace_tile_with_object(tile_pos, object_scene)

func _replace_tile_with_object(tile_pos: Vector2, object_scene: PackedScene, parent: Node = get_tree().current_scene):
	if get_cellv(tile_pos) != INVALID_CELL:
		set_cellv(tile_pos, -1)
		update_bitmask_region()
	
	if object_scene:
		var obj = object_scene.instance()
		var new_pos = map_to_world(tile_pos)+ half_size_cell
		new_pos.x = new_pos.x * scale.x
		new_pos.y = new_pos.y * scale.y
		var obj_pos = new_pos
		parent.add_child(obj)
		obj.global_position = obj_pos
		
