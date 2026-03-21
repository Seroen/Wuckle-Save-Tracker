extends ProgressBar
class_name CompletionBar


@export var trackers : Array[Tracker]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_bar():
	value = 0
	
	for tracker in trackers:
		for ach in tracker.achievement_data:
			if ach.completed == true:
				value += 1
	
	if value >= max_value:
		self_modulate.h = 0.33
		self_modulate.s = 1
	else:
		self_modulate.h = 0.33
		self_modulate.s = 0


func _on_refresh_timer_timeout() -> void:
	update_bar()
