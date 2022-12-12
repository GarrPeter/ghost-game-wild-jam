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
 

func _on_flashlight_hit(body):
	if body is WhiteGhost:
		body.freeze()




func _on_flashlight_exit(body):
	if body is WhiteGhost:
		if body.frozen:
			body.unfreeze()
