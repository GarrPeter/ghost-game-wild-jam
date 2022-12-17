extends AbstractBeam

const BATTERY_DRAIN = -2

func _ready():
	$SimpleBeamAnimatedSprite.play()

func beam_offset():
	return $SimpleBeamStartPosition.position


func _on_SimpleBeamBatteryTimer_timeout():
	emit_signal("beam_battery_delta", BATTERY_DRAIN)
