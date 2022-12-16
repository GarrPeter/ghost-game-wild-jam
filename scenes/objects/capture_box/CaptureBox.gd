extends Area2D

var captive_ghosts = 0

signal ghost_captured

func record_capture(ghost: AbstractGhost):
	captive_ghosts = captive_ghosts + 1
	emit_signal("ghost_captured", ghost)

func _on_CaptureBox_body_entered(body):
	if body.has_method("on_capture_box_enter"):
		body.on_capture_box_enter(self)
