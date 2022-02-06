extends Area2D


onready var player: Dwarf = get_tree().get_nodes_in_group("player").pop_front()
onready var cage: Cage = get_tree().get_nodes_in_group("cage").pop_front()
onready var animation: AnimationPlayer = $AnimationPlayer


func _ready():
	pass


func _on_Ending_body_entered(body):
	if (
		body.name == player.name and
		cage.is_grabbed()
	):
		animation.play("finish")


func go_to_ending_scene():
	var _ok = get_tree().change_scene("res://src/YouWin.tscn")
