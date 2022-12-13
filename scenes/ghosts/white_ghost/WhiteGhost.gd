extends AbstractGhost
class_name WhiteGhost

var screen_size
var original_rotation
var old_parent
var frozen = false

func _ready():
	$WhiteGhostAnimatedSprite.play()
	screen_size = get_viewport_rect().size
	original_rotation = self.rotation
	old_parent = self.get_parent()

func _physics_process(delta):
	if not frozen:
		move(delta)

func move(delta):
	var velocity = Vector2(cos(self.direction), sin(self.direction))
	velocity = velocity.normalized() * speed
	
	var collision = self.move_and_collide(velocity * delta)
	handle_border_collision()

	if collision:
		if not frozen:
			collision_bounce()

func handle_border_collision():
	var x_adjust = $WhiteGhostCollisionShape.shape.radius
	var y_adjust = $WhiteGhostCollisionShape.shape.height/2
	var clamp_x = clamp(self.position.x, x_adjust, screen_size.x - x_adjust)
	var clamp_y = clamp(self.position.y, y_adjust, screen_size.y - y_adjust)
	if clamp_x != position.x or clamp_y != position.y:
		position.x = clamp_x
		position.y = clamp_y
		if not frozen:
			collision_bounce()

func collision_bounce():
	var new_direction = self.direction - PI
	self.direction = rand_range(-PI/4, PI/4) + new_direction

func freeze():
	self.frozen = true

func unfreeze():
	self.frozen = false

func on_flashlight_hit(source):
	if not self.frozen and get_parent() == old_parent:
		transfer_owner(
			self,
			old_parent,
			source,
			source.get_relative_beam_position(self.position),
			self.rotation - source.rotation)
		self.freeze()

func on_flashlight_exit(source):
	if self.frozen and get_parent() != old_parent:
		transfer_owner(
			self,
			source,
			old_parent,
			self.get_global_position(),
			self.original_rotation)
		self.unfreeze()
