extends Node2D


func _ready():
	VisualServer.set_default_clear_color(Color(0.22, 0.32, 0.57))
	$Player.able_to_attack = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
