extends Area2D

export var speed = 300
var screen_size


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
		self.rotation = velocity.angle() + PI/2
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	var x_adjust = $HunterSprite.texture.get_width()/2
	var y_adjust = $HunterSprite.texture.get_height()/2
	position.x = clamp(position.x, x_adjust, screen_size.x - x_adjust)
	position.y = clamp(position.y, y_adjust, screen_size.y - y_adjust)

func use_flashlight(_delta):
	if Input.is_action_pressed("toggle_flashlight"):
		$SimpleBeam.visible = true
	else:
		$SimpleBeam.visible = false
