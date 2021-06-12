extends KinematicBody2D

enum Directions {
	None,
	Left,
	Right
}

onready var PositionLabel = $CanvasLayer/Label


##MOVEMENT VARIABLES
export var MovementSpeed = 32 * 4
export var CurrentDirection = Directions.None

var Arrived = true

##STARTING POSITION
var Spawnpoint = Vector2()
var StartingY = -64
var StartingX = 512

func _ready():
	Spawnpoint = Vector2(StartingX, StartingY)
	position = Spawnpoint
	
func _process(delta):
	
	PositionLabel.text = "Position\nX: " + str(position.x) + "\nY: " + str(position.y)
	
	_get_input()
	
	var X = position.x
	
	if CurrentDirection == Directions.Left:
		X -= MovementSpeed * delta
	if CurrentDirection == Directions.Right:
		X += MovementSpeed * delta
		
	position = Vector2(X,StartingY)
		
func _get_input():
	if Input.is_action_pressed("left"):
		Arrived = false
		CurrentDirection = Directions.Left
	if Input.is_action_pressed("right"):
		Arrived = false
		CurrentDirection = Directions.Right	
	if Input.is_action_just_released("left"):
		if !int(position.x) % 16 and Arrived == false:
			pass
		else:
			CurrentDirection = Directions.None
			Arrived = true
	if Input.is_action_just_released("right"):
		if !int(position.x) % 16 and Arrived == false:
			pass
		else:
			CurrentDirection = Directions.None
			Arrived = true

