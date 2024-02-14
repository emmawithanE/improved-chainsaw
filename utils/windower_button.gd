extends TextureButton
class_name WindowerButton

@export var target_scene : PackedScene

func _ready():
	button_down.connect(spawn_window)

func spawn_window():
	if target_scene:
		add_child(Utils.windowify(target_scene.instantiate()))
