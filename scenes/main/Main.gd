extends Node2D

var current_level_index = 0
var current_level

export var levels = [
	preload("res://scenes/levels/1Ghost.tscn"),
	preload("res://scenes/levels/2Ghosts.tscn")
]
func _ready():
	current_level = initialize_level(current_level_index)

func initialize_level(index: int):
	var level = levels[index].instance()
	self.add_child(level)
	yield(get_tree(), "idle_frame")
	if self.has_node("CaptureBox"):
		self.get_node("CaptureBox").initialize_signals(self)
	$HUD.ghosts_remaining = count_ghosts()
	return level

func on_capture_box_ghost_captured():
	$HUD.ghosts_remaining -= 1
	

func count_ghosts():
	return self.get_tree().get_nodes_in_group("ghosts").size()
