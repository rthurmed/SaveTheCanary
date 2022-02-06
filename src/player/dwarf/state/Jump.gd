extends State


const JUMP_MAX_POWER = 240

onready var player: Dwarf = owner
onready var max_hold_time: Timer = $MaxHoldTime
onready var min_jump_time: Timer = $MinJumpTime
onready var jump_meter: ProgressBar = get_node("../../UI/JumpMeter")
onready var sfx_jump: AudioStreamPlayer = get_node("../../Sound/Jump")


func handle_input(_event: InputEvent): pass


func process(_delta: float):
	if (
		Input.is_action_just_released("jump") or 
		not player.is_touching_ground()
	):
		transition("Air")
	
	if Input.is_action_just_pressed("jump"):
		player.animation.seek(0)
		max_hold_time.start(0)
		min_jump_time.start(0)
	
	jump_meter.value = percent_timer(max_hold_time) * 100
	jump_meter.visible = Input.is_action_pressed("jump")


func physics_process(_delta: float): pass


func enter():
	player.animation.play("jump")
	max_hold_time.start()
	min_jump_time.start()


func exit():
	var power = percent_timer(max_hold_time) * JUMP_MAX_POWER
	var direction = Vector2.UP + player.facing
	
	player.apply_central_impulse(direction * power)
	
	sfx_jump.play()
	
	max_hold_time.stop()
	min_jump_time.stop()


func _on_MaxHoldTime_timeout():
	if not active(): return
	transition("Air")


func _on_MinJumpTime_timeout():
	if not active(): return
	if not Input.is_action_pressed("jump"):
		transition("Air")


func percent_timer(timer: Timer):
	return (timer.wait_time - timer.time_left) / timer.wait_time
