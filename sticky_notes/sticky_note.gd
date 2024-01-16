extends Window

var mouse_offset : Vector2 = Vector2.ZERO
var following : bool = false

func _process(delta):
	if following:
		position = Vector2(get_tree().get_root().position) + get_parent().get_global_mouse_position() - mouse_offset
	
func init(col : Color = Color.BLACK):
	if col != Color.BLACK:
		$StickyNote.self_modulate = col
	else:
		var hue = randf()
		print(hue)
		$StickyNote.self_modulate = Color.from_hsv(hue, 0.2, 1)
	
	track_with_offset($StickyNote/Marker2D.position)
	
func track_with_offset(point : Vector2):
	mouse_offset = point
	following = true
	
func _top_bar_button_down():
	track_with_offset($StickyNote.get_local_mouse_position())

func _top_bar_button_up():
	following = false


func close():
	queue_free()
