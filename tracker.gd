extends Container
class_name Tracker


@export var achievement_data : Array[AchievementData]

var save_path : String = "C:/Users/Jivicks/AppData/LocalLow/Dark Machine/White Knuckle/save.json"
var ach_box_scene = preload("uid://bsug00hpl325e")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ach in achievement_data:
		var ach_box : AchievementBox = ach_box_scene.instantiate()
		ach_box.data = ach
		add_child(ach_box)
	
	update_tracker(save_path)


func update_tracker(filepath : String):
	var save_file = FileAccess.open(filepath, FileAccess.READ)
	
	var save_data : Dictionary = JSON.parse_string(save_file.get_as_text())
	var flags : Array = save_data["flags"]
	var stats : Array = save_data["gameStats"]["statistics"]
	var banks : Array = save_data["banks"]
	var modes : Array = save_data["gameModes"]
	
	save_file.close()
	
	for ach in achievement_data:
		for flag : Dictionary in flags:
			if flag.name == ach.flag:
				ach.completed = flag.value

		
		if ach.stat_id:
			var has_stat : bool = false
			for stat : Dictionary in stats:
				
				if ach.stat_id == stat.id:
					ach.stat_current = stat.value
					has_stat = true
			if has_stat == false:
				ach.stat_current = 0
				
		if ach.bank_goal:
			for bank in banks:
				ach.bank_max = max(ach.bank_max, bank.value)
		
		if ach.medal_goal:
			
			ach.medal_current = 0
			for mode in modes:
				if mode.name in ["Advanced Course", "Comms Array", "Fractured Territory", "Roach Run", "Shuttered Rift", "Parasite"]:
					for stat in mode.stats.statistics:
						if stat.id == "best-medal":
							if int(stat.value) >= ach.medal_type:
								ach.medal_current += 1


func _on_refresh_button_pressed() -> void:
	update_tracker(save_path)


func _on_refresh_timer_timeout() -> void:
	update_tracker(save_path)
