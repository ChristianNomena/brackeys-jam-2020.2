extends Node2D


var passager = false


func _ready():
	VisualServer.set_default_clear_color(Color(0.04, 0.24, 0.45))
	$Player.able_to_attack = true


func _process(delta):
#	if $CableCar.moving:
#		self.passager = true
#		$Player.hide()
#		$Player.position.x = $CableCar.position.x
#
#	if $CableCar.stop:
#		if self.passager:
#			$Player.position.x += 64
#			self.passager = false
#
#		$CableCar.position.x = $CableCar.position.x
#		$Player.show()
	pass
