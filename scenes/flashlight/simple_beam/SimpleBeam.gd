extends AbstractBeam

func _ready():
	$SimpleBeamAnimatedSprite.play()

func beam_offset():
	return $SimpleBeamStartPosition.position
