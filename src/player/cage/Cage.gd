class_name Cage
extends RigidBody2D


onready var player: Dwarf = get_tree().get_nodes_in_group("player").pop_front()
onready var collision: CollisionShape2D = $CollisionShape2D
onready var animation: AnimationPlayer = $AnimationPlayer
onready var state_machine: StateMachine = $StateMachine


func _ready():
	var _ok = player.connect("attacked", self, "_on_Player_attacked")


func _on_Player_attacked():
	state_machine.transition("Released")
