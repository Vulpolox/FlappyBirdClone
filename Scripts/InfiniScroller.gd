class_name InfiniScroller

# instance data
var image: Node2D # the image itself
var x_loop: float # the number of pixels the image will move before resetting position
var x_start: float # the starting x position of the image
var scroll_speed: float = 0.0 # the number of pixels / second that the image moves
var is_scroll: bool = true # flag for controlling scrolling


# constructor for class
func _init(image_to_set: Node2D):
	image = image_to_set
	x_start = image.position.x # initialize to image's starting x position
	

# pre  -- takes a delta parameter referring to the time elapsed since the previous frame
# post -- moves the Node2D to the left until its position.x == x_loop, then sets its position.x to x_start
func loop_and_scroll(delta) -> void:
	if is_scroll:
		
		# scroll the image
		image.position.x -= scroll_speed * delta
		
		# reset to image's starting when the image's position reaches x_loop
		if image.position.x <= -x_loop:
			image.position.x = x_start
	else:
		return # exit function
		

# pre  -- takes no arguments
# post -- flips the is_scroll flag to the opposite state
func toggle_scroll() -> void:
	is_scroll = not is_scroll
	
	
# pre  -- takes a float corresponding to the loop point to set
# post -- sets the x_loop instance data
func set_loop(x_loop_to_set: float) -> void:
	x_loop = x_loop_to_set
	

# pre  -- takes a float corresponding to the scroll speed
# post -- sets scroll_speed to the passed float
func set_scroll_speed(scroll_speed_to_set: float) -> void:
	scroll_speed = scroll_speed_to_set
