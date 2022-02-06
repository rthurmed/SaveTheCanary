class_name Dwarf
extends RigidBody2D


signal attacked

onready var animation: AnimationPlayer = $AnimationPlayer
onready var visual_instance = $VisualInstance
onready var wall_raycast = $VisualInstance/WallRaycast
onready var ground_raycast = $GroundMultiRaycast
onready var cage_position = $VisualInstance/Head/CagePosition
onready var sfx_damage = $Sound/Damage

var facing = Vector2.RIGHT


func _process(_delta):
	if not OS.is_debug_build():
		return
	if Input.is_action_pressed("debug_up"):
		global_position.y -= 16
	if Input.is_action_pressed("debug_down"):
		global_position.y += 16


func is_touching_ground():
	return ground_raycast.is_colliding()


func is_touching_wall():
	return wall_raycast.is_colliding()


func knockback(power: Vector2):
	sfx_damage.play()
	linear_velocity = power
	emit_signal("attacked")
