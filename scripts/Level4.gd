extends Node2D


func _ready():
	VisualServer.set_default_clear_color(Color(0.31, 0.48, 0.67))
	$Player.able_to_attack = true
	$Player.able_to_dash = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
