extends Node

signal highlight_changed(is_active : bool)
var kills : int = 0

var player : Player

var time_freeze :bool = false
var current_scene = get_tree().current_scene.scene_file_path
var just_unfreezed : bool = false
var cutscene : bool = false
func _process(delta: float) -> void:
	kills_pass()
	
func toggle_freeze():
	time_freeze = !time_freeze
	just_unfreezed = true
	highlight_changed.emit(time_freeze)
#new
func kills_pass() -> void:
	if kills<10 and current_scene=="res://assets/OurAssets/Maps/Bar/BarScene.tscn":
		#get_tree().change_scene_to_file()
		print("Kills =", kills)
	
