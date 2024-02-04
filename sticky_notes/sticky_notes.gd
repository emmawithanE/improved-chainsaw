extends Control

var note : PackedScene = preload("res://sticky_notes/sticky_note.tscn")
var colour_source : BucketSource

const COLOUR_COUNT : float = 12

func _ready():
	colour_source = BucketSource.new()
	var colour_array : Array[Color] = []
	for i in range(COLOUR_COUNT):
		var hue = float(i) / COLOUR_COUNT
		colour_array.append(Color.from_hsv(hue, 0.2, 1))
	colour_source.fill(colour_array)
	
func _on_button_button_down():
	var inst = note.instantiate()
	add_child(inst)
	inst.init(colour_source.draw())
	
