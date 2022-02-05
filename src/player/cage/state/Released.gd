extends State


onready var cage: Cage = owner


func handle_input(_event: InputEvent): pass
func process(_delta: float): pass
func physics_process(_delta: float): pass


func enter():
	cage.animation.play("released")


func exit(): pass


func _on_GrabArea_body_entered(body):
	if not active(): return
	if body.name == cage.player.name:
		transition("Grabbed")
