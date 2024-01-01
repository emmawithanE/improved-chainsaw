extends Control

@export var clock_frame : Control

@export_category("Hands")
@export var hour_visible : bool = true
@export var minute_visible : bool = true
@export var second_visible : bool = true

var midpoint : Vector2 = Vector2(0,0)
var hour_len : int
var minute_len : int
var second_len : int

func _ready():
	if clock_frame:
		midpoint = clock_frame.size / 2
		
		minute_len = min(midpoint.x, midpoint.y)
		second_len = minute_len * 0.8
		hour_len = minute_len * 0.3
		
		for child in clock_frame.get_children():
			if child is Line2D:
				(child as Line2D).points[0] = midpoint

func _process(_delta):
	if clock_frame and midpoint.length_squared() < 1:
		midpoint = clock_frame.size / 2
		
		minute_len = min(midpoint.x, midpoint.y)
		second_len = minute_len * 0.8
		hour_len = minute_len * 0.3
		
		for child in clock_frame.get_children():
			if child is Line2D:
				(child as Line2D).points[0] = midpoint
	
	if clock_frame:
		var time = Time.get_time_dict_from_system()
		
		# Draw clock hands :)
		var hour_hand : Line2D = clock_frame.get_node("HourHand")
		hour_hand.visible = hour_visible
		if hour_visible:
			var hour_angle = (-PI/2 + PI/6 * (time["hour"] + time["minute"]/60))
			hour_hand.points[1] = midpoint + Vector2(1,0).rotated(hour_angle)*hour_len

		var minute_hand : Line2D = clock_frame.get_node("MinuteHand")
		minute_hand.visible = minute_visible
		if minute_visible:
			var minute_angle = (-PI/2 + PI/30 * (time["minute"] + time["second"]/60))
			minute_hand.points[1] = midpoint + Vector2(1,0).rotated(minute_angle)*minute_len
		
		var second_hand : Line2D = clock_frame.get_node("SecondHand")
		second_hand.visible = second_visible
		if second_visible:
			var second_angle = (-PI/2 + PI/30 * (time["second"]))
			second_hand.points[1] = midpoint + Vector2(1,0).rotated(second_angle)*second_len
		
		queue_redraw()
	
func _draw():
	# draw a circle I hate it here
	draw_circle(midpoint + clock_frame.position, minute_len, Color(1,1,1,0.5))
