extends KinematicBody2D


var health = 100


func _ready():
	pass


func _process(delta):
	self.die_verification()


func hurt():
	self.health -= 50


func die_verification():
	if self.health == 0:
		self.queue_free()
