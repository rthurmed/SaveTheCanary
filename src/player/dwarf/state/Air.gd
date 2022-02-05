extends State


onready var player: Dwarf = owner
onready var delay: Timer = $Delay


func handle_input(_event: InputEvent): pass


func process(_delta: float):
	if player.is_touching_wall():
		player.facing.x = player.facing.x * -1
		player.visual_instance.scale.x = -1 if player.facing.x < 0 else 1
	
	if player.is_touching_ground() and delay.is_stopped():
		transition("Idle")


func physics_process(_delta: float): pass


func enter():
	player.animation.play("air")
	delay.start()


func exit():
	delay.stop()


func _on_Delay_timeout():
	pass # Replace with function body.
