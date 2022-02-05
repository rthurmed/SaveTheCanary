class_name Cage
extends RigidBody2D


onready var player: Dwarf = get_tree().get_nodes_in_group("player").pop_front()
onready var collision: CollisionShape2D = $CollisionShape2D
onready var animation: AnimationPlayer = $AnimationPlayer
