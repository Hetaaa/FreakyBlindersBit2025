extends Node

var current_scene = get_tree().current_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func kills_pass() -> void:
	if Global.kills==1 and current_scene.name==World3D:
		get_tree().change_scene_to_file("res://assets/OurAssets/Maps/Bar/BarScene.tscn")
	
