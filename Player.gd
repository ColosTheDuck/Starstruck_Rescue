extends KinematicBody2D


var movespeed = 500

var byte_scene = preload("res://Byte.tscn")
var byte_distance = 125

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
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		create_byte(event.global_position)
func create_byte(mouse_position):
	var byte = byte_scene.instance()
	var spawn_offset = (mouse_position - global_position).normalized() * byte_distance
	byte.position = global_position + spawn_offset
	get_parent().add_child(byte)
