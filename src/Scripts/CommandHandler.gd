extends Node2D

var Dog = null
onready var TextCommand = $CanvasLayer/CommandText
onready var CommandConfirm = $CanvasLayer/CommandConfirm

var CurrentCommand = ""

func _ready():
	Dog = get_parent().get_parent().get_node("Dog")
	
	if Input.is_action_just_pressed("confirm"):
		CurrentCommand = TextCommand.text
		TextCommand.text = ""
		Send_Command_To_Dog()
		print("THINGS HAPPENING")
	
func Send_Command_To_Dog():
	Dog.Recieve_Command(CurrentCommand)

func _on_CommandConfirm_pressed():
	CurrentCommand = TextCommand.text
	TextCommand.text = ""
	Send_Command_To_Dog()


func _on_Come_pressed():
	CurrentCommand = "come"
	Send_Command_To_Dog()

func _on_Go_pressed():
	CurrentCommand = "go"
	Send_Command_To_Dog()

func _on_Left_pressed():
	CurrentCommand = "left"
	Send_Command_To_Dog()

func _on_Right_pressed():
	CurrentCommand = "right"
	Send_Command_To_Dog()
