class_name Bat
extends Area2D


const SPEED = 1.2
const KNOCKBACK = 120
const MAX_DISTANCE_V = 100

export var kill = false

onready var player: Dwarf = get_tree().get_nodes_in_group("player").pop_front()
onready var animation: AnimationPlayer = $AnimationPlayer
onready var seek_raycast: RayCast2D = $SeekRaycast

var found_player = null


func _ready():
	animation.play("fly")


func _process(delta):
	if kill:
		queue_free()
	
	var curr_target = to_local(player.global_position)
	curr_target.y = clamp(curr_target.y, -MAX_DISTANCE_V, MAX_DISTANCE_V)
	seek_raycast.set_cast_to(curr_target)
	
	var collider = seek_raycast.get_collider()
	
	if seek_raycast.is_colliding() and not found_player:
		found_player = collider.name == player.name
	
	if (
		not seek_raycast.enabled or
		not found_player
	):
		return
	
	global_position = lerp(
		global_position,
		player.global_position,
		delta * SPEED
	)


func _on_Bat_body_entered(body):
	if not body.name == player.name:
		return
	
	var angle = (player.global_position - global_position).normalized()
	angle.y = 0
	player.knockback(angle * KNOCKBACK)
	
	animation.play("die")
