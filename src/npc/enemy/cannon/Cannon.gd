extends Area2D


const KNOCKBACK = 180
const BALL_SPEED = 100
const CannonBall = preload("res://src/npc/enemy/cannon/CannonBall.tscn")

onready var player: Dwarf = get_tree().get_nodes_in_group("player").pop_front()
onready var animation: AnimationPlayer = $AnimationPlayer
onready var cannon_ball_exit = $CannonBallExit


func _ready():
	animation.play("shoot")


func shoot():
	var ball = CannonBall.instance()
	ball.global_position = cannon_ball_exit.global_position
	ball.power = Vector2.LEFT * scale.x * BALL_SPEED
	get_tree().current_scene.add_child(ball)


func _on_Cannon_body_entered(body):
	if body.name == player.name:
		var angle = (player.global_position - global_position).normalized()
		player.knockback(angle * KNOCKBACK)
		animation.play("die")
