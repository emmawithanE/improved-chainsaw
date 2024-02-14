extends Node

func windowify(target : Node) -> Window:
	var window = Window.new()
	print(target.custom_minimum_size)
	window.size = target.custom_minimum_size
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	window.close_requested.connect(window.queue_free)
	window.add_child(target)
	return window
