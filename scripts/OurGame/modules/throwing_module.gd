extends Module


func Enter():
	player = get_parent().player

func PhysicsUpdate(_delta):
	if !player.pocket_item:
		player.changeModule(player.pickup_module)
	
	if Input.is_action_just_released("throw"):
		# Tworzenie nowej petardy
		var throwable_spawn : RigidBody3D = player.pocket_item
		get_tree().root.add_child(throwable_spawn)
		throwable_spawn.position = player.throw_point.global_position
		get_tree().current_scene.add_child(throwable_spawn)
		var throw_force = -15.0
		# Impuls rzutu
		var up_direction = 1.5
		var player_rotation = player.camera.global_transform.basis.z.normalized()
		throwable_spawn.freeze = false
		throwable_spawn.freeze_timer = 50 
		throwable_spawn.apply_central_impulse(player_rotation * throw_force + Vector3(0, up_direction, 0))
		# Losowy obrót
		player.change_animation("throw")
		throwable_spawn.angular_velocity = Vector3(
			randf_range(-10.0, 10.0),
			randf_range(-10.0, 10.0),
			randf_range(-10.0, 10.0)
		)
		throwable_spawn.show()
		player.changeModule(player.pickup_module)
