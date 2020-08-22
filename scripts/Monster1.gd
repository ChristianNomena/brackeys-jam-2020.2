extends KinematicBody2D


var health = 100


func _ready():
	$AnimationPlayer.play("idle")


func _process(delta):
	$AnimationPlayer.play("idle")


func hurt():
	self.health -= 100
	self.die_verification()


func die_verification():
	if self.health <= 0:
		self.queue_free()
