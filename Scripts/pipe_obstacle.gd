extends Node2D

# speed at which pipes approach player
var pipe_velocity: float = 60.0

# for random offset of pipe
var max_offset: int = 150
var min_offset: int = -150

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# make the pipes spawn in random locations
	var offset = randi_range(min_offset, max_offset)
	self.position.y += offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.position.x -= pipe_velocity * delta # make pipe approach player
