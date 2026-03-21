extends Control
class_name AchievementBox


@export var data : AchievementData


@export_group("Nodes")
@export var icon_node : TextureRect
@export var name_node : Label
@export var requ_node : Label
@export var check_node : Label

@export var stat_label : Label
@export var stat_bar : ProgressBar


func _ready() -> void:
	icon_node.texture = data.icon
	name_node.text = data.name
	requ_node.text = data.requirements

func _process(_delta : float):
	# this is bad and could do with a rewrite
	if data.stat_id != "":
		stat_label.show()
		stat_bar.show()
		
		stat_label.text = "%s/%s" % [data.stat_current, data.stat_goal]
		
		stat_bar.max_value = data.stat_goal
		stat_bar.value = data.stat_current
	
	if data.bank_goal:
		stat_label.show()
		stat_bar.show()
		
		stat_label.text = "%s/%s" % [data.bank_max, data.bank_goal]
		
		stat_bar.max_value = data.bank_goal
		stat_bar.value = data.bank_max
	
	if data.medal_goal:
		stat_label.show()
		stat_bar.show()
		
		stat_label.text = "%s/%s" % [data.medal_current, data.medal_goal]
		
		stat_bar.max_value = data.medal_goal
		stat_bar.value = data.medal_current
	
	if stat_bar.value >= stat_bar.max_value:
		stat_bar.self_modulate.h = 0.33
		stat_bar.self_modulate.s = 1
	else:
		stat_bar.self_modulate.h = 0.33
		stat_bar.self_modulate.s = 0
	
	if data.completed:
		check_node.show()
		
		icon_node.self_modulate.h = 0.33
		icon_node.self_modulate.s = 1
		
		name_node.self_modulate.h = 0.33
		name_node.self_modulate.s = 1
		
		requ_node.self_modulate.h = 0.33
		requ_node.self_modulate.s = 1
		
		stat_label.self_modulate.h = 0.33
		stat_label.self_modulate.s = 1
		
		#queue_free()
	else:
		check_node.hide()
		
		icon_node.self_modulate.h = 0.33
		icon_node.self_modulate.s = 0
		
		name_node.self_modulate.h = 0.33
		name_node.self_modulate.s = 0
		
		requ_node.self_modulate.h = 0.33
		requ_node.self_modulate.s = 0
		
		stat_label.self_modulate.h = 0.33
		stat_label.self_modulate.s = 0
