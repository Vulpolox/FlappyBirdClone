extends Node

@export var pipe_obstacle_scene : PackedScene

# variables for nodes in the scene
var bird: CharacterBody2D
var ground: Area2D
var pipe_timer: Timer

func _ready():
	
	# set references to nodes
	bird = $Bird
	ground = $Ground
	pipe_timer = $PipeTimer
	
	# connect ground's "ground_hit" signal to the hit() function
	ground.ground_hit.connect(hit)
	
	# connect bird's start_game signal to start function
	bird.start_game.connect(start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# called when the pipe timer runs out every 2.5 seconds
func _on_pipe_timer_timeout():
	generate_pipes()


# handles pipe spawning
func generate_pipes():
	var pipe_obstacle = pipe_obstacle_scene.instantiate()
	
	# connect the pipe_obstacles's score_point signal to the "score()" function
	pipe_obstacle.score_point.connect(increment_score)
	
	
	# connect pipe collision signals to the hit() function
	var upper_pipe = pipe_obstacle.get_node("UpperPipe")
	var lower_pipe = pipe_obstacle.get_node("LowerPipe")
	upper_pipe.bird_hit.connect(hit)
	lower_pipe.bird_hit.connect(hit)
	
	# add the instantiaed pipe obstacle to the scene tree
	self.add_child(pipe_obstacle)


# is called when the bird hits a pipe or the ground
func hit() -> void:
	
	bird.hit_obstacle = true # set the hit_obstacle flag to true
	ground.scroll_is_on = false # toggle off the ground scrolling
	
	# toggle off movement for all the pipes and turns off their cull timers
	var pipes_in_scene = get_tree().get_nodes_in_group("pipe_obstacles")
	for pipe in pipes_in_scene:
		pipe.is_pipe_moving = false
		pipe.get_node("CullTimer").stop()
	
	# stop more pipes from spawning
	pipe_timer.stop()
	
# increments the score
func increment_score() -> void:
	pass


# resets the game for the next round
func reset_game() -> void:
	bird.reset()


# starts the game after the player jumps
func start():
	pipe_timer.start()
