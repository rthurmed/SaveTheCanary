extends Area2D


const KNOCKBACK = 120

export var power: Vector2 = Vector2.LEFT


func _process(delta):
	global_position += power * delta


func _on_CannonBall_body_entered(body):
	if body.has_method("knockback"):
		var angle = (body.global_position - global_position).normalized()
		angle.y = 0
		body.knockback(angle * KNOCKBACK)
	queue_free()
