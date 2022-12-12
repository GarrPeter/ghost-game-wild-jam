extends KinematicBody2D

var speed = 450
var screen_size
export var direction = PI / 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$WhiteGhostAnimatedSprite.play()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move(delta)

func move(delta):
	var velocity = Vector2(cos(self.direction), sin(self.direction))
	print(velocity)
	velocity = velocity.normalized() * speed
	
	var collision = self.move_and_collide(velocity * delta)
	var x_adjust = $WhiteGhostCollisionShape.shape.radius
	var y_adjust = $WhiteGhostCollisionShape.shape.height/2
	var clamp_x = clamp(position.x, x_adjust, screen_size.x - x_adjust)
	var clamp_y = clamp(position.y, y_adjust, screen_size.y - y_adjust)
	if clamp_x != position.x or clamp_y != position.y:
		position.x = clamp_x
		position.y = clamp_y
		handle_border_collision()
		

	if collision:
		pass

func handle_border_collision():
	var new_direction = self.direction - PI
	self.direction = rand_range(-PI/4, PI/4) + new_direction
