extends KinematicBody2D
class_name Hunter

export var flashlight = preload("res://scenes/flashlight/simple_beam/SimpleBeam.tscn")
export var speed = 300
var screen_size

var flashlight_instance
var battery setget battery_set
signal battery_changed


func _ready():
	screen_size = get_viewport_rect().size
	
	# Establish starting flashlight battery
	var temp_flashlight = flashlight.instance()
	self.battery = temp_flashlight.battery
	temp_flashlight.queue_free()


func _process(delta):
	move(delta)
	use_flashlight(delta)

func move(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
	if Input.is_action_pressed("move_up"):
		velocity.y += -1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		if not Input.is_action_pressed("toggle_flashlight"):
			self.rotation = velocity.angle() + PI/2
		velocity = velocity.normalized() * speed
	
	var _collision = move_and_collide(velocity*delta)


func use_flashlight(_delta):
	if Input.is_action_pressed("toggle_flashlight"):
		create_flashlight()
	if Input.is_action_just_released("toggle_flashlight"):
		remove_flashlight()


func calc_beam_start_position(beam_offset: Vector2):
	return $HunterFlashlightPosition.position - beam_offset

func create_flashlight():
	if not is_instance_valid(flashlight_instance) or flashlight_instance == null:
		flashlight_instance = flashlight.instance()
		flashlight_instance.position = calc_beam_start_position(flashlight_instance.beam_offset())
		self.battery -= flashlight_instance.battery_activate_cost
		self.add_child(flashlight_instance)
		flashlight_instance.initialize_signals(self)

func remove_flashlight():
	if is_instance_valid(flashlight_instance):
		flashlight_instance.queue_free()

func on_flashlight_body_entered(body):
	if body.has_method("on_flashlight_hit"):
		body.on_flashlight_hit(self)


func on_flashlight_body_exited(body):
	if body.has_method("on_flashlight_exit"):
		body.on_flashlight_exit(self)

func on_beam_battery_delta(delta):
	self.battery += delta

func get_relative_beam_position(position: Vector2):
	return Vector2($HunterFlashlightPosition.position.x, self.to_local(position).y)

func battery_set(value):
	battery = value
	emit_signal("battery_changed", value)
