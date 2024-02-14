extends ColourUnit
class_name BaseColourUnit

@export var picker : ColorPickerButton

func _ready():
	col = picker.color
	picker.color_changed.connect(picker_colour_changed)

func init(_parent : ColourUnit, _h : float, _s : float, _v : float):
	#picker.color_changed.connect(picker_colour_changed)
	#picker.popup_closed.connect(picker_closed)
	#picker.picker_created.connect(func(): print("picker created"))
	pass

func picker_closed():
	print("closed")
	picker_colour_changed(picker.color)
		
func picker_colour_changed(colour : Color):
	col = colour
	print("colour changed")
	colour_changed.emit()
