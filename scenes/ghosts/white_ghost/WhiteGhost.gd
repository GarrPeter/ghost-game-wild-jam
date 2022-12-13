extends KinematicBody2D
class_name WhiteGhost

var speed = 150
var screen_size
export var direction = PI / 2
var frozen = false
var drag_velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$WhiteGhostAnimatedSprite.play()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not frozen:
		move(delta)
	if frozen:
		dragged_move(delta)

func move(delta):
	var velocity = Vector2(cos(self.direction), sin(self.direction))
	velocity = velocity.normalized() * speed
	
	var collision = self.move_and_collide(velocity * delta)
	handle_border_collision()

	if collision:
		pass

func dragged_move(delta):
	pass
#	var collision = self.move_and_slide(drag_velocity * delta)
#	handle_border_collision()

func handle_border_collision():
	var x_adjust = $WhiteGhostCollisionShape.shape.radius
	var y_adjust = $WhiteGhostCollisionShape.shape.height/2
	var clamp_x = clamp(self.position.x, x_adjust, screen_size.x - x_adjust)
	var clamp_y = clamp(self.position.y, y_adjust, screen_size.y - y_adjust)
	if clamp_x != position.x or clamp_y != position.y:
		position.x = clamp_x
		position.y = clamp_y
		if not frozen:
			var new_direction = self.direction - PI
			self.direction = rand_range(-PI/4, PI/4) + new_direction

func freeze():
	self.frozen = true

func unfreeze():
	self.frozen = false
