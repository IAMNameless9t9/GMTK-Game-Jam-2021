extends Node2D

onready var DevMap = preload("res://Scenes/DevLevel.tscn")
onready var Level0 = preload("res://Scenes/Level0.tscn")

onready var MainMenu = $MainMenu
onready var LevelSelect = $LevelSelect
onready var Pause = $Pause
onready var Settings = $Settings
onready var Credits = $Credits
onready var Controls = $Controls

var Menus = []
var currentMenu = null
var prevMenu = null

var enterPause = false

func _process(delta):
	if Input.is_action_just_pressed("confirm"):
		if !enterPause:
			currentMenu = Pause
			_swapMenu()
			enterPause = true

	$Debugger.text = str(enterPause)

func _ready():
	currentMenu = MainMenu
	Menus = [MainMenu, LevelSelect, Pause, Settings, Credits, Controls]
	
func _swapMenu():
	for M in Menus:
		if M != currentMenu:
			M.visible = false
		else:
			M.visible = true


## MAIN MENU BUTTONS
func _on_LevelSelect_MainMenu_pressed():
	prevMenu = currentMenu
	currentMenu = LevelSelect
	_swapMenu()
	$Background.visible = true
	$NewBackground.visible = false

func _on_Exit_MainMenu_pressed():
	get_tree().quit()

func _on_Credits_MainMenu_pressed():
	prevMenu = currentMenu
	currentMenu = Credits
	_swapMenu()
	$Background.visible = true
	$NewBackground.visible = false

func _on_Controls_MainMenu_pressed():
	prevMenu = currentMenu
	currentMenu = Controls
	_swapMenu()
	$Background.visible = true
	$NewBackground.visible = false

## LEVEL SELECT BUTTONS
func _on_Back_LevelSelect_pressed():
	currentMenu = prevMenu
	_swapMenu()
	$Background.visible = false
	$NewBackground.visible = true
	
func _on_DevLevel_pressed():
	currentMenu = null
	_swapMenu()
	$Background.visible = false
	$NewBackground.visible = false
	var game = DevMap.instance()
	$CurrentMap.add_child(game)
	
func _on_Level0_pressed():
	currentMenu = null
	_swapMenu()
	$Background.visible = false
	$NewBackground.visible = false
	var game = Level0.instance()
	$CurrentMap.add_child(game)

## CREDITS BUTTONS
func _on_Back_Credits_pressed():
	currentMenu = prevMenu
	_swapMenu()
	$Background.visible = false
	$NewBackground.visible = true

## CONTROLS BUTTONS
func _on_Back_Controls_pressed():
	currentMenu = prevMenu
	_swapMenu()
	$Background.visible = false
	$NewBackground.visible = true
	
## PAUSE MENU
func _on_Menu_Pause_pressed():
	currentMenu = MainMenu
	prevMenu = null
	_swapMenu()
	$Background.visible = false
	$NewBackground.visible = true
	enterPause = false
	$CurrentMap.get_child(0).queue_free()

func _on_LevelSelect_Pause_pressed():
	currentMenu = LevelSelect
	prevMenu = MainMenu
	_swapMenu()
	$Background.visible = true
	$NewBackground.visible = false
	enterPause = false
	$CurrentMap.get_child(0).queue_free()

func _on_Settings_Pause_pressed():
	currentMenu = Controls
	prevMenu = Pause
	$Background.visible = true
	$NewBackground.visible = false
	_swapMenu()

func _on_Exit_Pause_pressed():
	enterPause = false
	currentMenu = null
	$Background.visible = false
	$NewBackground.visible = false
	_swapMenu()
