extends Resource
class_name AchievementData

@export var icon : Texture2D
@export var name : String
@export var requirements : String
@export var flag : String
var completed : bool = false

@export_group("Stats")
@export var stat_id : String
@export var stat_goal : int
var stat_current : int

@export_group("Bank")
@export var bank_goal : int
var bank_max : int

@export_group("Medal")
@export var medal_type : int
@export var medal_goal : int
var medal_current : int
