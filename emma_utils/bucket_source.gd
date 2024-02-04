extends EmmaUtils
class_name BucketSource

# Util node: Insert an array by export or by code,
#            then call next() to get One Of Its Entries
#
#            Goes through every entry once, then shuffles, avoiding first-last match

@export var _all_values : Array = []
var _remaining_values : Array = []

func _ready():
	if _all_values:
		_generate_new_remaining()

func fill(val : Array):
	_all_values = val
	_generate_new_remaining()

func draw():
	var next = _remaining_values.pop_front()
	
	if _remaining_values.is_empty():
		_generate_new_remaining(next)
	
	return next

func _generate_new_remaining(previous = null):
	if _all_values.size() < 1:
		printerr("Bucket Source does not have value set to pick from")
		return
	
	_remaining_values.clear()
	_remaining_values = _all_values.duplicate()
	_remaining_values.shuffle()
	if previous and _remaining_values.size() > 1:
		while _remaining_values[0] == previous:
			_remaining_values.shuffle()

