extends State

var barrel_scene = preload("res://scenes/OurGame/bullet.tscn")

var shoot_timer : int = 30

func Enter():
	npc = get_parent().npc
	shoot_timer = 30
func PhysicsUpdate(delta: float) -> void:
	if npc.dead and !Global.time_freeze:
		Transitioned.emit(self, "Dead")
	if npc.freeze_factor <= 0.05:
		return
	if npc.see_player():
		
		var direction = npc.global_position.direction_to(Global.player.global_position)
		var target_rotation = Vector3(0, atan2(direction.x, direction.z), 0)
		npc.rotate_to_target(target_rotation)
		npc.gun_barrel.look_at(Global.player.global_position + Vector3(0,1,0), Vector3.UP)
		if shoot_timer == 0:
			shoot_timer = 30
			shoot()
		else:
			shoot_timer -=1
	else:
		Transitioned.emit(self, "Walk")

func shoot():
	var instance = barrel_scene.instantiate()
	# ustaw transform lufy zanim dodasz (ładniej, ale nie obowiązkowe jeśli przekazujesz direction)
	instance.global_transform = npc.gun_barrel.global_transform
	get_tree().root.add_child(instance)

	# określ kierunek w stronę gracza
	var dir = (Global.player.global_position + Vector3(0,1.4,0) - npc.gun_barrel.global_position).normalized()

	# odpalisz pocisk z określonym kierunkiem
	instance.launch(dir, instance.speed)
