extends State

func Enter():
	npc = get_parent().npc
	await get_tree().create_timer(2.0, false).timeout
	npc.queue_free()
