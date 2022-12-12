extends Area2D

func _ready():
	$SimpleBeamAnimatedSprite.play()


func _process(_delta):
	pass



# Manually add handlers since dynamically creating beam
func initialize_signals(object):
	self.add_body_entered_handler(object, "on_SimpleBeam_body_entered")
	self.add_body_exited_handler(object, "on_SimpleBeam_body_exited")

func add_body_entered_handler(object, methodName):
	self.connect("body_entered", object, methodName)

func add_body_exited_handler(object, methodName):
	self.connect("body_exited", object, methodName)


#func _on_SimpleBeam_body_entered(body):
#	emit_signal("flashlight_hit", body)
#
#
#
#func _on_SimpleBeam_body_exited(body):
#	emit_signal("flashlight_exit", body)
