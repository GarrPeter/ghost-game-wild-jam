extends KinematicBody2D
class_name AbstractGhost

export (int) var speed
export (float) var direction

func move(_delta):
	pass

func transfer_owner(child, former_parent, new_parent, new_position, new_rotation):
	if child.get_parent() == former_parent:
		former_parent.remove_child(child)
		child.position = new_position
		child.rotation = new_rotation
		new_parent.call_deferred("add_child", child)
		yield(new_parent.get_tree(), "idle_frame")

func on_flashlight_hit(_source):
	pass

func on_flashlight_exit(_source):
	pass
