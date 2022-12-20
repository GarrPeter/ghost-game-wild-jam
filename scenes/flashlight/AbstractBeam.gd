extends Area2D
class_name AbstractBeam

export var battery = 100
export var battery_activate_cost = 5

signal beam_battery_delta

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
	self.add_beam_battery_delta(object, "on_beam_battery_delta")

func add_body_entered_handler(object, methodName):
	var _error = self.connect("body_entered", object, methodName)

func add_body_exited_handler(object, methodName):
	var _error = self.connect("body_exited", object, methodName)

func add_beam_battery_delta(object, methodName):
	var _error = self.connect("beam_battery_delta", object, methodName)
