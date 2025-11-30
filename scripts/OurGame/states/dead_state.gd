extends State

var isdead = false

func Enter():
	npc = get_parent().npc

	if npc.has_signal("died") and isdead == false:
		isdead = true
		npc.emit_signal("died")
		print("died")
	
	npc.change_animation("die")

	# Czekamy aż animacja się skończy
	await get_tree().create_timer(2.5, false).timeout
	
	npc.queue_free()
