extends PanelContainer
class_name ColourUnit

@export var hue_field : TextEdit
@export var sat_field : TextEdit
@export var val_field : TextEdit

@export var display_panel : Panel

var _parent : ColourUnit
var hue_shift : float:
	set(value):
		hue_shift = value
		regenerate_colour()
var sat_shift : float:
	set(value):
		sat_shift = value
		regenerate_colour()
var val_shift : float:
	set(value):
		val_shift = value
		regenerate_colour()

var col : Color

signal colour_changed()

func setters_visible(vis : bool):
	$VBoxContainer/HBoxContainer.visible = vis

func init(parent : ColourUnit, h : float, s : float, v : float):
	_parent = parent
	
	hue_field.text = str(h)
	sat_field.text = str(s)
	val_field.text = str(v)
	
	hue_field.text_changed.connect(hue_set)
	sat_field.text_changed.connect(sat_set)
	val_field.text_changed.connect(val_set)
	
	hue_set()
	sat_set()
	val_set()
	
	_parent.colour_changed.connect(regenerate_colour)

func regenerate_colour() -> void:
	var new_colour = _parent.get_colour()
	new_colour.h += hue_shift
	new_colour.s += sat_shift
	new_colour.v += val_shift
	
	col = new_colour
	
	display_panel.modulate = col
	display_panel.tooltip_text = tooltip(col)
	
	colour_changed.emit()

func tooltip(col : Color):
	var string = str(round(col.h * 360)) + ", " + str(round(col.s * 100)) + ", " + str(round(col.v * 100))
	return string

func get_colour() -> Color:
	return col

func hue_set():
	var hue_raw := float(hue_field.text)
	# Hue is an angle from 0-360, divide by 360.0
	hue_shift = hue_raw / 360.0

func sat_set():
	var sat_raw := float(sat_field.text)
	# Sat is a number 0-100
	sat_shift = sat_raw / 100.0

func val_set():
	var val_raw := float(val_field.text)
	# Val is a number 0-100
	val_shift = val_raw / 100.0
