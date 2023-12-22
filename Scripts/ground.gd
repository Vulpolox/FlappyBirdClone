extends Area2D

signal ground_hit

var scroll_speed: float = 120.0 # speed at which the ground moves (frames / second)
var scroll_is_on: bool = true # flag for ground scrolling


func _process(delta):
	
	# scroll the ground if the scroll flag is set to true
	if scroll_is_on:
		scroll_ground(delta)
	

# scrolls the ground
func scroll_ground(delta):
	# move the ground to the left
	self.position.x -= scroll_speed * delta
	
	# if the ground's x position is 2304, it is time to loop it
	if self.position.x <= -1152:
		self.position.x = 0


# if something hits the ground
func _ground_is_hit(body):
	
	# if the node that hit the gound is in the "player" group
	if body.is_in_group("player"):
		print("player hit the ground")
		ground_hit.emit()
