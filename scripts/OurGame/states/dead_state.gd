extends State

func Enter():
	npc = get_parent().npc
	npc.change_animation("die")
	Global.kills = Global.kills + 1
	await get_tree().create_timer(2.5, false).timeout
	npc.queue_free()
