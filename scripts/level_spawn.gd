extends Node3D

var enemy_scene = preload("res://scenes/OurGame/enemy.tscn")
@onready var spawns = $Spawns
@onready var goals = $Goals
@onready var enemies = $Enemies
var cursor : int = 0
var cursor_max : int = 0

var dead_enemies_count = 0 # Licznik
@export var required_kills = 2    # Cel

signal level_won_and_changed(level_path : String)
signal level_lost


func _on_enemy_died():
	dead_enemies_count += 1
	print("Zabito wrogów: ", dead_enemies_count)
	
	if dead_enemies_count >= required_kills:
		level_won_and_changed.emit("res://assets/OurAssets/Maps/Burger/burgerscene.tscn")		
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dead_enemies_count = 0
	Global.cutscene = true
	cursor_max = spawns.get_children().size() 
	await get_tree().create_timer(2.0,false).timeout
	for i in range(cursor_max):
		var enemy_instance = enemy_scene.instantiate()
		enemies.add_child(enemy_instance)
		enemy_instance.died.connect(_on_enemy_died)
		enemy_instance.global_position = spawns.get_children()[i].global_position
		enemy_instance.nav_agent.target_position = goals.get_children()[i].global_position
	await get_tree().create_timer(1.0,false).timeout
	Global.cutscene = false
	


func _on_player_player_dead() -> void:
	level_lost.emit()
	self.process_mode = Node.PROCESS_MODE_DISABLED
	
