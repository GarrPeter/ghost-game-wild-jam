extends KinematicBody2D
class_name AbstractGhost

export (int) var speed
export (float) var direction
export (bool) var capturable

func move(_delta):
	push_error("move not set in " + self.get_name())

func transfer_owner(child, former_parent, new_parent, new_position, new_rotation):
	if child.get_parent() == former_parent:
		former_parent.remove_child(child)
		child.position = new_position
		child.rotation = new_rotation
		new_parent.call_deferred("add_child", child)
		yield(new_parent.get_tree(), "idle_frame")

func on_flashlight_hit(_source):
	push_error("on_flashlight_hit not set in " + self.get_name())

func on_flashlight_exit(_source):
	push_error("on_flashlight_exit not set in " + self.get_name())

func on_capture_box_enter(source):
	# Can be changed to have more logic later
	source.capture_ghost(self)
	queue_free()
