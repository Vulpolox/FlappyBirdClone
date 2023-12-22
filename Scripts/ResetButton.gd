extends Button


@export var offset: int = 20 # number of pixels the button starts above the end location
@export var button_speed: float = 75 # number of pixels per second that the button approaches the end position

var end_position # where the button is placed in the editor
var opacity_percentage: float # calculated as distance y from end position's y over offset

func _ready():
	
	# make the button invisible (set opacity to 0)
	self.modulate = Color(1, 1, 1, 0.0)
	
	# the button's end position will be where it is placed in the editor; the button is them moved "offset"
	# pixels above this position
	end_position = self.position
	self.position.y -= offset


func _process(delta):
	
	# if the button hasn't reached the end position yet
	if self.position.y < end_position.y:
		opacity_percentage = 1 - abs((end_position.y - self.position.y) / offset) # calculate opacity percentage
		self.modulate = Color(1, 1, 1, opacity_percentage) # update opacity / opacity will increase as linear function of distance between current and end position
		self.position.y += button_speed * delta # move button towards end position
		
	else:
		self.modulate = Color(1, 1, 1, 1)

