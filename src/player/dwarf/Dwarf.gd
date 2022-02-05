class_name Dwarf
extends RigidBody2D


onready var animation: AnimationPlayer = $AnimationPlayer
onready var visual_instance = $VisualInstance
onready var wall_raycast = $VisualInstance/WallRaycast
onready var ground_raycast = $GroundMultiRaycast
onready var cage_position = $VisualInstance/Head/CagePosition

var facing = Vector2.RIGHT


func is_touching_ground():
	return ground_raycast.is_colliding()


func is_touching_wall():
	return wall_raycast.is_colliding()

