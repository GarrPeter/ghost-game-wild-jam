extends Node2D


func _ready():
	pass # initialize_hunter_signals()


#func initialize_hunter_signals():
#	# Will need to be connected on Ghost spawn - i.e. for each new ghost
#	var _error = $Hunter.connect("flashlight_hit", $WhiteGhost, "_on_flashlight_hit")
#	_error = $Hunter.connect("flashlight_exit", $WhiteGhost, "_on_flashlight_exit")

#func transfer_owner(child, old_parent, new_parent, new_position, new_rotation):
#	if child.get_parent() == old_parent:
#		old_parent.remove_child(child)
#		child.position = new_position
#		child.rotation = new_rotation
#		new_parent.call_deferred("add_child", child)
#		yield(get_tree(), "idle_frame")

#func _on_flashlight_hit(body):
#	if body is WhiteGhost:
#		if not body.frozen and body.get_parent() != $Hunter:
#			transfer_owner(
#				body,
#				self,
#				$Hunter, 
#				Vector2($Hunter.get_node("FlashlightPosition").position.x,
#						$Hunter.to_local(body.position).y),
#				body.rotation - $Hunter.rotation)
#			body.freeze()
#
#func _on_flashlight_exit(body):
#	if body is WhiteGhost and body.get_parent() == $Hunter:
#		if body.frozen:
#			transfer_owner(body, $Hunter, self, body.get_global_position(), body.original_rotation)
#			body.unfreeze()
