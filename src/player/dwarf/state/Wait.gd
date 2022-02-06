extends State


onready var player: Dwarf = owner
onready var delay: Timer = $Delay


func handle_input(_event: InputEvent): pass


func process(_delta: float):
	if Input.is_action_just_pressed("jump"):
		transition("Jump")


func physics_process(_delta: float): pass


func enter():
	player.animation.play("RESET")
	delay.start()


func exit():
	delay.stop()


func _on_Delay_timeout():
	if not active(): return
	transition("Jump")
