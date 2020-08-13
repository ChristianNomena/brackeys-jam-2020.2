extends Control


func _ready():
	VisualServer.set_default_clear_color(Color(0, 0, 0))


func _process(delta):
	if Input.is_action_just_released("accept_control"):
		get_tree().change_scene("res://scenes/levels/Level4.tscn")
