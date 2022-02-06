extends State


onready var cage: Cage = owner


func handle_input(_event: InputEvent): pass


func process(delta: float):
	var target: Position2D = cage.player.cage_position
	
	cage.global_transform.origin = lerp(
		cage.global_transform.origin,
		target.global_position,
		delta * 24
	)
	
	cage.global_rotation = lerp(
		cage.global_rotation,
		0,
		delta * 24
	)
	
	if Input.is_action_just_pressed("drop"):
		transition("Released")


func physics_process(_delta: float): pass


func enter():
	cage.animation.play("grabbed")
	
	cage.collision.set_deferred("disabled", true)
	cage.set_deferred("mode", RigidBody2D.MODE_STATIC)


func exit():
	cage.collision.set_deferred("disabled", false)
	cage.set_deferred("mode", RigidBody2D.MODE_RIGID)
	cage.call_deferred("apply_central_impulse", Vector2.UP * 100)
