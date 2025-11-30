extends CharacterBody3D
class_name Npc

var SPEED = 2.5
var can_walk : bool = true
@onready var nav_agent : NavigationAgent3D = $NavAgent

@onready var hit_dealer : Area3D = $HitDeal

@onready var hit_box : Area3D = $Hitbox

var freeze_factor := 1.0          # 1.0 = normalna prędkość, 0.0 = zamrożony
var freeze_speed := 5.0           # jak szybko zwalnia (im większe tym szybciej)
var is_frozen := false

@export var attack_type = 0 #0 - shoot/ 1- melee
@onready var player_seek_ray : RayCast3D = $PlayerSeek
@onready var gun_barrel : Node3D = $Enemy_model/rig_001/Skeleton3D/BoneAttachment3D/WeaponBone/colt/GunBarrel
@onready var anim_tree : AnimationTree = $AnimationTree
var dead : bool = false

var weapon = 0 #0 - pistol/ 1 - shotgun
var spot_meter : int = 0
func _physics_process(delta: float) -> void:
	if Global.time_freeze == true:
		is_frozen = true
	else:
		
		is_frozen = false
	
	if is_frozen:
		freeze_factor = lerp(freeze_factor, 0.0, delta * freeze_speed)
	else:
		freeze_factor = lerp(freeze_factor, 1.0, delta * freeze_speed)
	spot_meter -=10
func walk(delta):
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
func see_player():
	player_seek_ray.look_at(Global.player.global_position+ Vector3(0,1.5,0))
	if player_seek_ray.is_colliding():
		var col = player_seek_ray.get_collider()
		if col.is_in_group("player"):
			return true
	return false


func _on_hitbox_body_entered(body: Node3D) -> void:
	
	if body is RigidBody3D:
		print(body.linear_velocity.length())
		if body.saved_dir:
			if body.linear_velocity.length() > 0.7:
				dead = true
		else:
			if body.linear_velocity.length() > 1.0:
				dead = true
		

func change_animation(anim):
	if anim_tree:
		anim_tree.set("parameters/Transition/transition_request", anim)
		anim_tree.set("parameters/TimeSeek/seek_request", 0.0)

func weapon_pick():
	if weapon == 0:
		pass
