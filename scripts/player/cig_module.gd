extends Module


func Enter():
	player = get_parent().player
	await get_tree().create_timer(1.8,false).timeout
	player.change_animation("smoke")
	player.mouse_block =true
	player.movement_block = true
	player.cig_mesh.show()
	await get_tree().create_timer(1.5,false).timeout
	player.cig_mesh.hide()
	shoot()
	await get_tree().create_timer(0.2,false).timeout
	await get_tree().create_timer(0.3,false).timeout
	player.changeModule(player.pickup_module)
func shoot():
	var projectile := preload("res://scenes/pet_throwable.tscn").instantiate()
	get_tree().root.add_child(projectile)
	# Ustaw pozycję pocisku na pozycji gracza
	projectile.global_position = player.throw_point.global_position

	# Oblicz kierunek przód + trochę do góry
	var forward = player.global_transform.basis.z * -1
	var up = player.global_transform.basis.y
	var direction = (forward + up * 0.5).normalized()   # 0.2 = ile ma być w górę

	# Nadaj impuls (tylko dla RigidBody3D)
	var shoot_force = 4.0
	projectile.freeze_timer = 60
	projectile.slowing_val = 0.95
	projectile.angular_velocity = Vector3(
			randf_range(-10.0, 10.0),
			randf_range(-10.0, 10.0),
			randf_range(-10.0, 10.0)
		)
	projectile.apply_impulse(direction * shoot_force)
func Exit():
	player.mouse_block =false
	player.movement_block = false
