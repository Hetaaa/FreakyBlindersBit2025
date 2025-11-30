extends Module

func Enter():
	player = get_parent().player
	

func PhysicsUpdate(delta):
	if player.vis_ray.is_colliding() and player.vis_ray.get_collider() is Area3D and player.vis_ray.get_collider() != player:
		if Input.is_action_just_pressed("pickup"):
			var item : RigidBody3D = player.vis_ray.get_collider().get_parent()
			item.linear_velocity = Vector3.ZERO
			item.angular_velocity = Vector3.ZERO
			player.change_animation("pickup")
			await get_tree().create_timer(0.3,false).timeout
			item.hide()
			await get_tree().create_timer(0.2,false).timeout
			player.pickup(item.duplicate())
			item.queue_free()
			
		
