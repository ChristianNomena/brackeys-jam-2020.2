extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	
func _on_mouse_entered():
	if (label):
		label.set("custom_colors/font_color", "8b4545")
	
func _on_mouse_exited():
	if (label):
		label.set("custom_colors/font_color", "ffffff")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
