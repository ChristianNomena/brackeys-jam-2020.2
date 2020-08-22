extends Node2D


var verification = true


func _ready():
	VisualServer.set_default_clear_color(Color(0.40, 0.72, 0.98))
	$Player.able_to_attack = true
	$Player.able_to_dash = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if verification:
		if $Boss3.health == 10:
			$MapLevel5/Control/Label.show()
			verification = false
