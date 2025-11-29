extends CharacterBody3D
class_name Npc

var SPEED = 3.0
var can_walk : bool = true
@onready var nav_agent : NavigationAgent3D = $NavAgent

@onready var hit_dealer : Area3D = $HitDeal

@onready var hit_box : Area3D = $Hitbox

var freeze_factor := 1.0          # 1.0 = normalna prędkość, 0.0 = zamrożony
var freeze_speed := 5.0           # jak szybko zwalnia (im większe tym szybciej)
var is_frozen := false

func _physics_process(delta: float) -> void:
	if Global.time_freeze == true:
		is_frozen = true
	else:
		is_frozen = false
	
func walk(delta):
	if is_frozen:
		freeze_factor = lerp(freeze_factor, 0.0, delta * freeze_speed)
	else:
		freeze_factor = lerp(freeze_factor, 1.0, delta * freeze_speed)

	if freeze_factor <= 0.01:
		return

	
	var next_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_pos)
	var new_vel = direction * SPEED
	
	var target_rotation = Vector3(0, atan2(direction.x, direction.z), 0)
	rotate_to_target(target_rotation)
	
	if nav_agent.avoidance_enabled:
		can_walk = true
		_on_navigation_agent_3d_velocity_computed(new_vel)
	else:
		velocity = velocity.move_toward(new_vel, 100)
		velocity *= freeze_factor
		if !nav_agent.is_target_reached():
			move_and_slide()

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	move_and_slide()
	
func rotate_to_target(target):
	rotation = rotation.lerp(target, 0.1)

func hit():
	for area in hit_dealer.get_children():
		if area != hit_box:
			if area.has_method("get_hit"):
				area.get_hit(10)
