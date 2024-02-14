extends Control

@export var vbox : VBoxContainer

var colours : int = 9
var rows : int = 6
var row_shift : float = 60
var hue_shift : float = 10
var sat_shift : float = -10
var val_shift : float = 10

var base_unit : PackedScene = preload("res://colour_palleter/BaseColourUnit.tscn")
var normal_unit : PackedScene = preload("res://colour_palleter/ColourUnit.tscn")

func _ready():
	var base = gen_base_row()
	
	for i in range(rows - 1):
		base = gen_child_row(base)
	

func gen_base_row():
	var row = HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	# Generate the base
	var base = base_unit.instantiate()
	row.add_child(base)
	
	var last_unit = base
	
	for i in range((colours - 1)/2):
		var new_unit = normal_unit.instantiate() as ColourUnit
		new_unit.init(last_unit, (hue_shift * -1.0), sat_shift, (val_shift * -1.0))
		row.add_child(new_unit)
		row.move_child(new_unit, 0)
		last_unit = new_unit
	
	last_unit = base
	for i in range((colours - 1)/2):
		var new_unit = normal_unit.instantiate() as ColourUnit
		new_unit.init(last_unit, hue_shift, sat_shift, val_shift)
		row.add_child(new_unit)
		last_unit = new_unit
	
	vbox.add_child(row)
	return base


func gen_child_row(last_base : ColourUnit):
	var row = HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	# Generate the base
	var base = normal_unit.instantiate()
	base.init(last_base, row_shift, 0, 0)
	row.add_child(base)
	
	var last_unit = base
	
	for i in range((colours - 1)/2):
		var new_unit = normal_unit.instantiate() as ColourUnit
		new_unit.init(last_unit, (hue_shift * -1.0), sat_shift, (val_shift * -1.0))
		row.add_child(new_unit)
		row.move_child(new_unit, 0)
		last_unit = new_unit
	
	last_unit = base
	for i in range((colours - 1)/2):
		var new_unit = normal_unit.instantiate() as ColourUnit
		new_unit.init(last_unit, hue_shift, sat_shift, val_shift)
		row.add_child(new_unit)
		last_unit = new_unit
	
	vbox.add_child(row)
	return base
