extends State

var isdead = false
var flash_mat = preload("res://assets/OurAssets/Textures/flash.tres")
func Enter():
	npc = get_parent().npc

	if npc.has_signal("died") and isdead == false:
		isdead = true
		npc.emit_signal("died")
		print("died")
	
	npc.change_animation("die")
	npc.model.set_surface_override_material(0,flash_mat)
	await get_tree().create_timer(0.1, false).timeout
	npc.model.set_surface_override_material(0,null)
	# Czekamy aż animacja się skończy
	await get_tree().create_timer(2.5, false).timeout
	
	npc.queue_free()
