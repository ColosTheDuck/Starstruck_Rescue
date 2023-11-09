extends KinematicBody2D

export var strength = 200
var movespeed = 500

var byte_scene = preload("res://Scenes/Byte.tscn")
var byte_distance = 125

var attack_enabled = false
var attack_direction = Vector2(0, 0)  # The initial direction of the attack
var attack_range = 60

func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_down"):
		motion.y += 1
	if Input.is_action_pressed("move_up"):
		motion.y -= 1
	if Input.is_action_pressed("move_right"):
		motion.x += 1
	if Input.is_action_pressed("move_left"):
		motion.x -= 1
	motion = motion.normalized()
	motion = move_and_slide(motion*movespeed)
	look_at(get_global_mouse_position())
	
	if attack_enabled:
		$AttackHitbox.global_position = global_position + attack_direction * attack_range
		$AttackHitbox.rotation = attack_direction.angle()  # Rotate the hitbox to face the attack direction
		$Melee_Attack.animation = "melee_attack"
		$Melee_Attack.global_position = global_position + attack_direction * attack_range
		emit_signal("melee_interact")
	else:
		$AttackHitbox.disabled = true
		$AttackHitbox.global_position = Vector2(-10000, -10000)  # Move the hitbox off-screen when not attacking
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			attack_enabled = true
			attack_direction = global_position.direction_to(get_global_mouse_position())
		else:
			attack_enabled = false
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		create_byte(event.global_position)
func create_byte(mouse_position):
	var byte = byte_scene.instance()
	var spawn_offset = (mouse_position - global_position).normalized() * byte_distance
	byte.position = global_position + spawn_offset
	get_parent().add_child(byte)


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.


func _on_Melee_Attack_animation_finished():
	$Melee_Attack.animation = "idle"
