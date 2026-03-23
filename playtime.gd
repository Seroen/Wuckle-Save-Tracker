extends Label


var save_path : String = "C:/Users/Jivicks/AppData/LocalLow/Dark Machine/White Knuckle/save.json"

@export var completion_bar : CompletionBar

var synced_time : String
var time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sync_timer(save_path)


func _process(delta: float) -> void:
	time += delta
	
	var hours = int(time / 3600)
	var minutes = int((time - (hours * 3600)) / 60)
	var seconds = time - (hours * 3600) - (minutes * 60)
	
	text = "%2s:%2s:%.3f" % [hours, minutes, seconds]


func sync_timer(filepath : String):
	var save_file = FileAccess.open(filepath, FileAccess.READ)
	if save_file == null:
		return
	var save_data : Dictionary = JSON.parse_string(save_file.get_as_text())
	
	for stat in save_data.gameStats.statistics:
		if stat.id == "game-time":
			var save_time = stat.value
			
			if save_time != synced_time:
				time = float(save_time)
				synced_time = save_time
	
	save_file.close()


func _on_refresh_timer_timeout() -> void:
	sync_timer(save_path)
