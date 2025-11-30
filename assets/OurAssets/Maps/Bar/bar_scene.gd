extends Node3D

signal level_won_and_changed(level_path : String)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	level_won_and_changed.emit("res://assets/OurAssets/Maps/Burger/burgerscene.tscn") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
