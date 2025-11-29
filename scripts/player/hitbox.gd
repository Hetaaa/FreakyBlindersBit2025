extends Area3D


func get_hit(amount):
	get_parent().take_dmg(amount)
