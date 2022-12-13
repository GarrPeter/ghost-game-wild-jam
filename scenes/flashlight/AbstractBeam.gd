extends Area2D
class_name AbstractBeam

func beam_offset():
	# Offset of the beam for positioning purposes
	# i.e. return $AbstractBeamStartPosition
	push_error("beam_offset not set in " + self.get_name())

# Manually add handlers since dynamically creating beam
func initialize_signals(object):
#	Wrapper to initialize any signals. These are connected to the parent (Hunter)
#	in order to 'bubble' the signal up. Require at least body_entered and body_exited
	self.add_body_entered_handler(object, "on_flashlight_body_entered")
	self.add_body_exited_handler(object, "on_flashlight_body_exited")

func add_body_entered_handler(object, methodName):
	var _error = self.connect("body_entered", object, methodName)

func add_body_exited_handler(object, methodName):
	var _error = self.connect("body_exited", object, methodName)
