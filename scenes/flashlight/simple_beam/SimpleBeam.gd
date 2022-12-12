extends Area2D
signal flashlight_hit
signal flashlight_exit

func _ready():
	$SimpleBeamAnimatedSprite.play()


func _process(_delta):
	pass


func _on_SimpleBeam_body_entered(body):
	if self.visible:
		emit_signal("flashlight_hit", body)



func _on_SimpleBeam_body_exited(body):
	if self.visible:
		emit_signal("flashlight_exit", body)
