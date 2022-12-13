extends KinematicBody2D
class_name Hunter

signal flashlight_hit
signal flashlight_exit

export var flashlight = preload("res://scenes/flashlight/simple_beam/SimpleBeam.tscn")
export var speed = 300
var screen_size
var captured_ghosts = []

var flashlight_instance
const flashlight_offset = Vector2(15, -58)


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	
	move_and_collide(velocity*delta)
#	position += velocity * delta
#	var x_adjust = $HunterSprite.texture.get_width()/2
#	var y_adjust = $HunterSprite.texture.get_height()/2
#	position.x = clamp(position.x, x_adjust, screen_size.x - x_adjust)
#	position.y = clamp(position.y, y_adjust, screen_size.y - y_adjust)

func use_flashlight(_delta):
	if Input.is_action_pressed("toggle_flashlight"):
		create_flashlight()
	if Input.is_action_just_released("toggle_flashlight"):
		remove_flashlight()


func create_flashlight():
	if not is_instance_valid(flashlight_instance) or flashlight_instance == null:
		flashlight_instance = flashlight.instance()
		flashlight_instance.position = flashlight_offset
		self.add_child(flashlight_instance)
		flashlight_instance.initialize_signals(self)

func remove_flashlight():
	if is_instance_valid(flashlight_instance):
		flashlight_instance.queue_free()

# Echo signals up
func on_SimpleBeam_body_entered(body):
	emit_signal("flashlight_hit", body)

func on_SimpleBeam_body_exited(body):
	emit_signal("flashlight_exit", body)
