extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_hunter_signals()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize_hunter_signals():
	$Hunter.connect("flashlight_hit", self, "_on_flashlight_hit")
	$Hunter.connect("flashlight_exit", self, "_on_flashlight_exit")

func transfer_owner(child, old_parent, new_parent, new_position):
	if child.get_parent() == old_parent:
		old_parent.remove_child(child)
		child.position = new_position
		new_parent.call_deferred("add_child", child)
		yield(get_tree(), "idle_frame")

func _on_flashlight_hit(body):
	if body is WhiteGhost:
		if not body.frozen and body.get_parent() != $Hunter:
			transfer_owner(
				body,
				self,
				$Hunter, 
				Vector2($Hunter.flashlight_offset.x,
						$Hunter.to_local(body.position).y))
			body.freeze()

func _on_flashlight_exit(body):
	if body is WhiteGhost and body.get_parent() == $Hunter:
		if body.frozen:
			transfer_owner(body, $Hunter, self, body.get_global_position())
			body.unfreeze()
