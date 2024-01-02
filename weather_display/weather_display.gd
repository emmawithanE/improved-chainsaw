extends Control

@export var state_id : String = "IDS60901"# SA: IDS60901
@export var station_id : int = 94648 # Adelaide: 94648

var request_url : String

func _ready():
	request_url = ("http://www.bom.gov.au/fwo/" + state_id + "/" 
				   + state_id + "." + str(station_id) + ".json")
	
	$HTTPRequest.request_completed.connect(request_completed)
	$HTTPRequest.request(request_url)
	
func request_completed(result : int, response_code : int, headers : PackedStringArray, body : PackedByteArray):
	if result == HTTPRequest.RESULT_SUCCESS:
		var json = JSON.parse_string(body.get_string_from_utf8())
		var location = json["observations"]["data"][0]["name"]
		var app_t = json["observations"]["data"][0]["apparent_t"]
		print("Apparent temperature in ", location, ": ", app_t, "°C")
		
		var refreshed = json["observations"]["header"][0]["refresh_message"]
		var temp_recorded : String = json["observations"]["data"][0]["local_date_time"].split("/")[1]
		print(refreshed, " (recorded at ", temp_recorded, ")")
		
		$Panel/MarginContainer/HBoxContainer/TempLabel.text = "[right]" + str(app_t) + "°C[/right]"
		$Panel/MarginContainer/HBoxContainer/ConditionLabel.text = json["observations"]["data"][0]["cloud"]
		
	else:
		print("error: ", result)
