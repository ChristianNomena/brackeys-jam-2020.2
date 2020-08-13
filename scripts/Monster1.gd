extends Node2D


var health = 100


func _ready():
	pass


func _process(delta):
	pass


func hurt():
	self.health -= 100
	self.die_verification()


func die_verification():
	if self.health <= 0:
		self.queue_free()
