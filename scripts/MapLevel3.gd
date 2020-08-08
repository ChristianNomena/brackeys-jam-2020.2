extends Node2D


var count = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if count == 2:
		get_tree().change_scene("res://scenes/levels/Level4.tscn")


func _on_Timer_timeout():
	count += 1
