class_name Dwarf
extends RigidBody2D


const MIN_FLOOR_ANGLE = 0.7

onready var animation: AnimationPlayer = $AnimationPlayer
onready var visual_instance = $VisualInstance
onready var wall_raycast = $VisualInstance/WallRaycast
onready var ground_raycast = $GroundMultiRaycast

var is_on_ground = false
var floor_normal = Vector2()
var floor_angle = 0.0
var facing = Vector2.RIGHT


func is_touching_ground():
	return ground_raycast.is_colliding()
	# return is_on_ground


func is_touching_wall():
	return wall_raycast.is_colliding()


func _integrate_forces(state):
	var count_floor_contacts = 0
	
	is_on_ground = false
	floor_normal = Vector2()
	floor_angle = 0.0
	
	for i in range(0, state.get_contact_count()):
		var pos = to_local(state.get_contact_local_position(i))
		if pos.normalized().y > MIN_FLOOR_ANGLE:
			count_floor_contacts += 1
			floor_normal += state.get_contact_local_normal(i)
	
	is_on_ground = count_floor_contacts > 0
	
	if is_on_ground:
		floor_normal = floor_normal / count_floor_contacts
		floor_angle = floor_normal.angle() + deg2rad(90)
