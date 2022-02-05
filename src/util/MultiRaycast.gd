extends Node2D


func is_colliding():
	# Checks if any of the child raycasts is colliding
	var result = false
	for child in get_children():
		if not child.has_method('is_colliding'):
			continue
		if child.is_colliding():
			result = true
	return result
