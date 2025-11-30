extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	Global.toggle_freeze()
	get_tree().call_group("time_display", "show")


func _on_unfreeze_timeout() -> void:
	Global.toggle_freeze()
	get_tree().call_group("time_display", "hide")
