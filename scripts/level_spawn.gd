extends Node3D

var enemy_scene = preload("res://scenes/OurGame/enemy.tscn")
@onready var spawns = $Spawns
@onready var goals = $Goals
@onready var enemies = $Enemies
var cursor : int = 0
var cursor_max : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.cutscene = true
	cursor_max = spawns.get_children().size() 
	await get_tree().create_timer(2.0,false).timeout
	for i in range(cursor_max):
		var enemy_instance = enemy_scene.instantiate()
		enemies.add_child(enemy_instance)
		enemy_instance.global_position = spawns.get_children()[i].global_position
		enemy_instance.nav_agent.target_position = goals.get_children()[i].global_position
	await get_tree().create_timer(4.0,false).timeout
	Global.cutscene = false
	
