extends Control

@export var vbox : VBoxContainer

var colours : int = 9
var rows : int = 12
var row_shift : float = 30
var hue_shift : float = 10
var sat_shift : float = -10
var val_shift : float = 10

var base_unit : PackedScene = preload("res://colour_palleter/BaseColourUnit.tscn")
var normal_unit : PackedScene = preload("res://colour_palleter/ColourUnit.tscn")

func _ready():
	var last_row = gen_base_row()
	
	for i in range(rows - 1):
		last_row = gen_child_row(last_row)
	

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
	return row


func gen_child_row(last_row : HBoxContainer):
	var row = HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	# Generate the cells
	
	for child in last_row.get_children():
		if child is ColourUnit:
			
			var new_unit = normal_unit.instantiate() as ColourUnit
			new_unit.init(child, row_shift, 0, 0)
			new_unit.setters_visible(false)
			row.add_child(new_unit)
	
	vbox.add_child(row)
	return row
	
	#var base = normal_unit.instantiate()
	#base.init(last_base, row_shift, 0, 0)
	#row.add_child(base)
	#
	#var last_unit = base
	#
	#for i in range((colours - 1)/2):
		#var new_unit = normal_unit.instantiate() as ColourUnit
		#new_unit.init(last_unit, (hue_shift * -1.0), sat_shift, (val_shift * -1.0))
		#row.add_child(new_unit)
		#row.move_child(new_unit, 0)
		#last_unit = new_unit
	#
	#last_unit = base
	#for i in range((colours - 1)/2):
		#var new_unit = normal_unit.instantiate() as ColourUnit
		#new_unit.init(last_unit, hue_shift, sat_shift, val_shift)
		#row.add_child(new_unit)
		#last_unit = new_unit
	#
	#vbox.add_child(row)
	#return base


func save_palette():
	var image = Image.create(colours, rows, false, Image.FORMAT_RGB8)
	print(image.get_size())
	
	for i in range(len(vbox.get_children())):
		var row = vbox.get_child(i)
		for j in range(len(row.get_children())):
			var unit = row.get_child(j) as ColourUnit
			
			image.set_pixel(j, i, unit.get_colour())
	
	var dialog = FileDialog.new()
	dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	dialog.size = Vector2(600, 600)
	
	add_child(dialog)
	dialog.show()
	var location : String = await dialog.file_selected
	print(location)
	if location:
		image.save_png(location)
	

func convert_png_to_gpl():
	
	# Get the image
	var load_dialog = FileDialog.new()
	load_dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	load_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	load_dialog.add_filter("*.png")
	
	load_dialog.size = Vector2(600, 600)
	
	add_child(load_dialog)
	load_dialog.show()
	
	var file_name : String = await load_dialog.file_selected
	print("loading image at: ", file_name)
	var image := Image.new()
	image.load(file_name)
	
	# Get a location to save to
	
	var save_dialog = FileDialog.new()
	save_dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	save_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	save_dialog.add_filter("*.gpl")
	
	save_dialog.size = Vector2(600, 600)
	
	add_child(save_dialog)
	save_dialog.show()
	
	var save_file_name : String = await save_dialog.file_selected

	var new_file = FileAccess.open(save_file_name, FileAccess.WRITE)
	
	new_file.store_string(
"""GIMP Palette
#Palette Name: EDIT
#Description: EDIT.\n"""
	)

	var image_size := image.get_size()
	new_file.store_string("#Colors: " + str(image_size.x * image_size.y) + "\n")
	
	for row in image_size.y:
		for col in image_size.x:
			var colour := image.get_pixel(col, row)
			var string = str(colour.r8) + "\t" +\
			str(colour.g8) + "\t" +\
			str(colour.b8) + "\t" + \
			colour.to_html(false) + "\n"
			new_file.store_string(string)
	
	new_file.close()






























