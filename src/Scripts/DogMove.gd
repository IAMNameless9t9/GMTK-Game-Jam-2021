extends Area2D

var tile_size = 16 * 4
var transition_speed = 2
var inputs = {"up": Vector2.UP, "down": Vector2.DOWN}

onready var ray = $RayCast2D
onready var tween = $Tween

var EnableSnapping = true
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
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move_snapped(dir)
			
func move_snapped(dir):
	ray.cast_to = inputs[dir] * (tile_size * 2) * deltaTime
	ray.force_raycast_update()
	if !ray.is_colliding():
		##position += inputs[dir] * tile_size
		
		move_tween_snapped(dir)
		
func move_tween_snapped(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/transition_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func Recieve_Command(command):
	CurrentCommand = command
	
	


