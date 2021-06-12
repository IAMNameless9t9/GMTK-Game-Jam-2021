extends Area2D

var tile_size = 16 * 4
var transition_speed = 2
var inputs = {"left": Vector2.LEFT, "right": Vector2.RIGHT, "up": Vector2.UP, "down": Vector2.DOWN}

onready var ray = $RayCast2D
onready var tween = $Tween


#Command Interpretation

var KnownCommands = ["left", "right", "come", "go"]
var CurrentCommand = ""
var deltaTime = null

func _process(delta):
	deltaTime = delta

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * (tile_size / 2)
	
func _unhandled_input(event):
	if tween.is_active():
		return
	var indexOfCommand = KnownCommands.find(CurrentCommand)
	var currentIndex = 0
	for dir in inputs.keys():
		if currentIndex == indexOfCommand:
			move(dir)
			CurrentCommand = ""
		currentIndex += 1
			
func move(dir):
	ray.cast_to = inputs[dir] * tile_size * deltaTime
	ray.force_raycast_update()
	if !ray.is_colliding():
		##position += inputs[dir] * tile_size
		
		move_tween(dir)
		
func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/transition_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func Recieve_Command(command):
	CurrentCommand = command
	
	


