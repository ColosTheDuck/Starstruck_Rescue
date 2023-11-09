extends RigidBody2D

var strength = 200
var target_to_mouse

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("melee_interact", self, "_on_MeleeInteract")

func _on_MeleeInteract():
	target_to_mouse = (get_global_mouse_position() - $Byte.global_position).normalized()
	
func _process(delta):
	if not target_to_mouse == null:
		var force = target_to_mouse * strength
		$Byte.apply_central_impulse(force)
		target_to_mouse = null
