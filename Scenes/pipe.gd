extends Area2D

signal bird_hit

func _pipe_is_hit(body):
	
	# check if the collision was caused by the birb
	if body.is_in_group("player"):
		print("pipe was hit by bird")
		bird_hit.emit()
