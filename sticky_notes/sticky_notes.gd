extends Control

var note : PackedScene = preload("res://sticky_notes/sticky_note.tscn")

func _on_button_button_down():
	var inst = note.instantiate()
	add_child(inst)
	inst.init()
	
