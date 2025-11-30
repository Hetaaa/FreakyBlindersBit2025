extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# Czekamy jedną klatkę fizyki, żeby LevelManager zdążył podłączyć sygnał
	await get_tree().process_frame
	
	print("Emituję sygnał zmiany poziomu teraz!")
	level_won_and_changed.emit("res://assets/OurAssets/Maps/Burger/burgerscene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
