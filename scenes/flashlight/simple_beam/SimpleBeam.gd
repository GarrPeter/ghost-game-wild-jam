extends Area2D
signal flashlight_hit

func _ready():
	$SimpleBeamAnimatedSprite.play()


func _process(_delta):
	pass


func _on_SimpleBeam_body_entered(_body):
	emit_signal("flashlight_hit")
