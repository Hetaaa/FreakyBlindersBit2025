extends State

func Enter():
	npc = get_parent().npc
	npc.change_animation("die")
	await get_tree().create_timer(2.5, false).timeout
	npc.queue_free()
