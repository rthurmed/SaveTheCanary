extends State


onready var player: Dwarf = owner


func handle_input(_event: InputEvent): pass


func process(_delta: float):
	if Input.is_action_just_pressed("jump"):
		transition("Jump")
	
	if not player.is_touching_ground():
		transition("Air")


func physics_process(_delta: float): pass


func enter():
	player.animation.play("idle")


func exit(): pass
