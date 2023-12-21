extends Node2D

# signals
signal score_point

# speed at which pipes approach player (pixels / second)
var pipe_velocity: float = 120.0

# for random offset of pipe
var max_offset: int = 300
var min_offset: int = -150

# flags
var is_pipe_moving = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# make the pipes spawn in random locations
	var offset = randi_range(min_offset, max_offset)
	self.position.y += offset
	
	# make the pipe part of the pipe_obstacle group
	self.add_to_group("pipe_obstacles")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if is_pipe_moving:
		move_pipe(delta)


# destroys the pipe after existing for 20 seconds
func _on_cull_timer_timeout():
	print("deleted pipe")
	self.queue_free()


# moves pipe left towards player
func move_pipe(delta):
	self.position.x -= pipe_velocity * delta # make pipe approach player


# is called when the player hits the score region
func _on_score_region_body_entered(body):
	print("score region hit")
	score_point.emit()
