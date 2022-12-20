extends Node2D

var current_level_index = 1
var current_level

export var levels = [
	preload("res://scenes/levels/1Ghost.tscn"),
	preload("res://scenes/levels/2Ghosts.tscn")
]
func _ready():
	current_level = initialize_level(current_level_index)
	yield(get_tree(), "idle_frame")
	initialize_hud()

func initialize_level(index: int):
	var level = levels[index].instance()
	self.add_child(level)
	return level

func initialize_hud():
	initialize_capture_boxes()
	initialize_battery()
	initialize_ghosts_remaining()

func initialize_capture_boxes():
	var boxes = get_group("capture_boxes")
	for box in boxes:
		box.initialize_signals(self)

func initialize_battery():
	var hunters = get_group("hunters")
	if not hunters.empty():
		var hunter = hunters[0]
		hunter.initialize_signals(self)
		$HUD.battery_remaining = hunter.battery

func initialize_ghosts_remaining():
	$HUD.ghosts_remaining = count_ghosts()

func get_group(group):
	return self.get_tree().get_nodes_in_group(group)

func on_capture_box_ghost_captured():
	$HUD.ghosts_remaining -= 1

func on_battery_changed(value):
	$HUD.battery_remaining = value

func count_ghosts():
	return self.get_tree().get_nodes_in_group("ghosts").size()
