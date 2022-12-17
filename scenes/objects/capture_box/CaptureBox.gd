extends Area2D

var captive_ghosts = 0

signal ghost_captured

func record_capture(_ghost: AbstractGhost):
	captive_ghosts = captive_ghosts + 1
	emit_signal("ghost_captured")

func _on_CaptureBox_body_entered(body):
	if body.has_method("on_capture_box_enter"):
		body.on_capture_box_enter(self)

func initialize_signals(object):
#	Wrapper to initialize any signals. These are connected to the parent (Main/Level scenes)
#	in order to 'bubble' the signal up.
	self.add_ghost_captured_handler(object, "on_capture_box_ghost_captured")

func add_ghost_captured_handler(object, methodName):
	var _error = self.connect("ghost_captured", object, methodName)
