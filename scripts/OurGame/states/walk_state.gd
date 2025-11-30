extends State

func Enter():
	npc = get_parent().npc
	npc.change_animation("run")

func PhysicsUpdate(delta: float) -> void:
	if npc.dead and !Global.time_freeze:
		Transitioned.emit(self, "Dead")
	
	
	if npc.attack_type == 0:
		if !Global.cutscene:
			npc.nav_agent.target_position = Global.player.global_position
			if npc.see_player():
				Transitioned.emit(self,"Shoot")
		else:
			if npc.nav_agent.is_target_reached():
				Transitioned.emit(self,"Shoot")
	npc.walk(delta)
