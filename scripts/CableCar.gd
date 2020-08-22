extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 200

var moving = false
var stop = false
var used = false


func _ready():
	pass


# warning-ignore:unused_argument
func _physics_process(delta):
	if not(used):
		if self.moving:
			self.road_to_the_boss()
		
		if self.stop:
			self.stop_to_fight()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		self.moving = true

	if body.is_in_group("arret"):
		self.moving = false
		self.stop = true
		body.queue_free()


func road_to_the_boss():
	self.velocity = Vector2(self.speed, 0)
	self.velocity = self.move_and_slide(velocity)


func stop_to_fight():
	self.velocity = Vector2.ZERO
	self.used = true
