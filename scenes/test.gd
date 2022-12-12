extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


 

func _on_SimpleBeam_flashlight_hit(body):
	if body is WhiteGhost:
		body.freeze()




func _on_SimpleBeam_flashlight_exit(body):
	if body is WhiteGhost:
		if body.frozen:
			body.unfreeze()
