extends Area2D

func _ready():
	$SimpleBeamAnimatedSprite.play()


func _process(_delta):
	pass

func beam_offset():
	return $SimpleBeamStartPosition.position

# Manually add handlers since dynamically creating beam
func initialize_signals(object):
	self.add_body_entered_handler(object, "on_SimpleBeam_body_entered")
	self.add_body_exited_handler(object, "on_SimpleBeam_body_exited")

func add_body_entered_handler(object, methodName):
	var _error = self.connect("body_entered", object, methodName)

func add_body_exited_handler(object, methodName):
	var _error = self.connect("body_exited", object, methodName)
