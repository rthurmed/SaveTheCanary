class_name Bat
extends Area2D


const SPEED = .8
const KNOCKBACK = 120
const MAX_DISTANCE_V = 100

onready var player: Dwarf = get_tree().get_nodes_in_group("player").pop_front()
onready var animation: AnimationPlayer = $AnimationPlayer
onready var seek_raycast: RayCast2D = $SeekRaycast

export var kill = false


func _ready():
	animation.play("fly")


func _process(delta):
	if kill:
		queue_free()
	
	var target = to_local(player.global_position)
	target.y = clamp(target.y, -MAX_DISTANCE_V, MAX_DISTANCE_V)
	seek_raycast.set_cast_to(target)
	
	if (
		not seek_raycast.enabled or
		not seek_raycast.is_colliding()
	):
		return
	
	var collider = seek_raycast.get_collider()
	
	if collider.name == player.name:
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
