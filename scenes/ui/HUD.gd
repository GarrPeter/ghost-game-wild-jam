extends CanvasLayer

const GHOSTS_REMAINING_LABEL = "Ghosts Remaining: %s"
const BATTERY_LABEL = "Battery Remaining: %s"

var ghosts_remaining = 0 setget ghosts_remaining_set
var battery_remaining = 100 setget battery_remaining_set

func _ready():
	$GhostsRemainingLabel.text = GHOSTS_REMAINING_LABEL % ghosts_remaining
	$BatteryLabel.text = BATTERY_LABEL % battery_remaining

func ghosts_remaining_set(ghosts_count):
	ghosts_remaining = ghosts_count
	$GhostsRemainingLabel.text = GHOSTS_REMAINING_LABEL % ghosts_remaining

func battery_remaining_set(battery_value):
	battery_remaining = battery_value
	$BatteryLabel.text = BATTERY_LABEL % battery_remaining
