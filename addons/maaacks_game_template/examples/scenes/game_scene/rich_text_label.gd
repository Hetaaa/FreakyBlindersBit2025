extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_timer_label(new_time):
	# Opcja 1: Wyświetl same sekundy (zaokrąglone)
	text = "⌛ %.1f ⌛" % new_time
