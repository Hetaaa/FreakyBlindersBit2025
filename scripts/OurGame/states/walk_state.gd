extends State

func Enter():
	npc = get_parent().npc

func PhysicsUpdate(delta: float) -> void:
	npc.nav_agent.target_position = Global.player.global_position
	npc.walk(delta)
