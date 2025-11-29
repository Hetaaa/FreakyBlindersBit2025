extends State

func Enter():
	npc = get_parent().npc

func PhysicsUpdate(delta: float) -> void:
	if npc.dead and !Global.time_freeze:
		Transitioned.emit(self, "Dead")
	npc.nav_agent.target_position = Global.player.global_position
	npc.walk(delta)
	if npc.attack_type == 0:
		if npc.see_player():
			Transitioned.emit(self,"Shoot")
