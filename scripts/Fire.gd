extends KinematicBody2D


var speed = 500
var velocity = Vector2.ZERO


func _ready():
	pass


func _physics_process(delta):
	var collision = move_and_collide(self.velocity * delta)
	
	if collision:
		if "enemy" in collision.collider.get_groups():
			collision.collider.hurt()
		
		print("bye2")
		self.queue_free()


func new_start(position, direction):
	if direction == -1:
		$Sprite.flip_h = true
	
	self.position = position
	self.velocity = Vector2(speed * direction, 0)
